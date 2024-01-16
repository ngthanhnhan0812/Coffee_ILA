// ignore: file_names
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/models/blog.dart';
import 'package:coffee/src/models/commentBlog.dart';
import 'package:comment_tree/comment_tree.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

List<commentBlog> parseCommentBlog(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<commentBlog>((json) => commentBlog.fromJson(json)).toList();
}

Future<List<commentBlog>> fetchAllCommentFromAPI(int idBlog) async {
  final response = await http
      .get(Uri.parse('$u/api/Comment/userViewAllCommentBlog?idBlog=$idBlog'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseCommentBlog(response.body);
  } else {
    throw Exception(
        'Unable to fetch Comment from the REST API of comments.dart!');
  }
}

Future<List<commentBlog>> fetchMainCommentFromAPI(int idBlog) async {
  final response = await http
      .get(Uri.parse('$u/api/Comment/userGetCommentBlogM?idBlog=$idBlog'));
  // ignore: avoid_print
  print(response.body);

  if (response.statusCode == 200) {
    // return parseCommentBlog(response.body);
    List jsonResponse = await json.decode(response.body);
    return jsonResponse.map((data) => commentBlog.fromJson(data)).toList();
  } else {
    throw Exception(
        'Unable to fetch Comment from the REST API of comments.dart!');
  }
}

Future<List<commentBlog>> fetchSubCommentFromAPI(int idBlog) async {
  final response = await http
      .get(Uri.parse('$u/api/Comment/userGetSubCommentBlog?idBlog=$idBlog'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseCommentBlog(response.body);
  } else {
    throw Exception(
        'Unable to fetch Comment from the REST API of comments.dart!');
  }
}

Future<http.Response> deleteComment(int idComment, int idBlog) async {
  var commentB = {};
  commentB['id'] = idComment;
  commentB['idBlog'] = idBlog;
  final response = await http.get(
      Uri.parse(
          '$u/api/Comment/userDeleteCommentBlog?idComment=$idComment&idBlog=$idBlog'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print('Delete comment successfully!');
  } else {
    // ignore: avoid_print
    print(
        'Failed to delete comment: ${response.statusCode}\t ${response.body}');
  }
  return response;
}

Future<http.Response> editComment(String comment, int id) async {
  var commentB = {};
  commentB['id'] = id;
  commentB['comment'] = comment;
  final response = await http.get(
      Uri.parse('$u/api/Comment/userEditCommentBlog?content=$comment&idCM=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print('update comment successfully!');
  } else {
    // ignore: avoid_print
    print(
        'Failed to update comment: ${response.statusCode}\t ${response.body}');
  }
  return response;
}

class CommentsBlog extends StatefulWidget {
  final Blog blog;
  final TextEditingController textEditingController;
  final int idBlog;
  final Function(int)? onReplySelected;
  const CommentsBlog(
      {super.key,
      required this.idBlog,
      required this.textEditingController,
      required this.blog,
      this.onReplySelected});

  @override
  State<CommentsBlog> createState() => _CommentsState();
}

class _CommentsState extends State<CommentsBlog> {
  List<Widget> commentWidgets = [];
  int? selectedCommentId;
  void onReplySelected(int id) {
    setState(() {
      selectedCommentId = id;
    });
  }

  Map<Comment, int> commentMainId = {};
  Map<Comment, int> commentSubId = {};
  @override
  void initState() {
    super.initState();
    fetchAllCommentFromAPI(widget.idBlog);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: fetchAllCommentFromAPI(widget.idBlog),
          builder: (context, snapshot) {
            List<Comment> mainComments = [];
            List<List<Comment>> subComments = [];
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              for (var commentBlog in snapshot.data as List<commentBlog>) {
                var newComment = Comment(
                  avatar: commentBlog.userAvatar,
                  userName: commentBlog.userName,
                  content: commentBlog.comment,
                );
                mainComments.add(newComment);
                commentMainId[newComment] = commentBlog.id!;

                List<Comment> tempSubComments = [];
                for (var subComment in commentBlog.lsSubComment!) {
                  var newSubComment = Comment(
                    avatar: subComment.userAvatar,
                    userName: subComment.userName,
                    content: subComment.comment,
                  );
                  tempSubComments.add(newSubComment);
                  commentSubId[newSubComment] = subComment.id!;
                }
                subComments.add(tempSubComments);
                // for (var subComment in commentBlog.lsSubComment!) {
                //   tempSubComments.add(Comment(
                //     avatar: subComment.userAvatar,
                //     userName: subComment.userName,
                //     content: subComment.comment,
                //   ));
                // }
                // subComments.add(tempSubComments);
              }

              for (int i = 0; i < mainComments.length; i++) {
                commentWidgets.add(Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: CommentTreeWidget<Comment, Comment>(
                    mainComments[i],
                    subComments[i],
                    treeThemeData: const TreeThemeData(
                        lineColor: Color.fromARGB(255, 233, 229, 229),
                        lineWidth: 2),
                    avatarRoot: avatarRoot,
                    avatarChild: avatarChild,
                    contentRoot: (context, snapshot) {
                      return InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.white),
                        onLongPress: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                  padding: const EdgeInsets.all(15),
                                  child: ListBody(
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.edit),
                                        title: const Text('Edit'),
                                        onTap: () {
                                          var currentComment =
                                              snapshot.content.toString();
                                          widget.textEditingController.text =
                                              currentComment;
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: SingleChildScrollView(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          avatarRoot(context,
                                                              snapshot),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              controller: widget
                                                                  .textEditingController,
                                                              maxLines: null,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            editComment(
                                                                widget
                                                                    .textEditingController
                                                                    .text,
                                                                commentMainId[
                                                                    snapshot]!),
                                                        child:
                                                            const Text('Edit'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.delete),
                                        title: const Text('Delete'),
                                        onTap: () async {
                                          await deleteComment(
                                              commentMainId[snapshot]!,
                                              widget.idBlog);
                                          setState(() {
                                            commentWidgets.removeAt(i);
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.userName.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    snapshot.content.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 14, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text('5d'),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    SizedBox(
                                      height: 34,
                                      width: 60,
                                      child: TextButton(
                                          onPressed: () {
                                            var commentId =
                                                commentMainId[snapshot];
                                            widget.onReplySelected
                                                ?.call(commentId!);
                                            widget.textEditingController.text =
                                                '@${snapshot.userName} ';
                                          },
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.grey[700])),
                                          child: const Text('Reply')),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    contentChild: (context, snapshot) {
                      return InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.white),
                        onLongPress: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                  padding: const EdgeInsets.all(15),
                                  child: ListBody(
                                    children: <Widget>[
                                      ListTile(
                                        leading: const Icon(Icons.edit),
                                        title: const Text('Edit'),
                                        onTap: () {
                                          var currentComment =
                                              snapshot.content.toString();
                                          widget.textEditingController.text =
                                              currentComment;
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: SingleChildScrollView(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          avatarChild(context,
                                                              snapshot),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          SizedBox(
                                                            width: 280,
                                                            child:
                                                                TextFormField(
                                                              controller: widget
                                                                  .textEditingController,
                                                              maxLines: null,
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            editComment(
                                                                widget
                                                                    .textEditingController
                                                                    .text,
                                                                commentSubId[
                                                                    snapshot]!),
                                                        child:
                                                            const Text('Edit'),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.delete),
                                        title: const Text('Delete'),
                                        onTap: () async {
                                          await deleteComment(
                                              commentSubId[snapshot]!,
                                              widget.idBlog);
                                          setState(() {
                                            commentWidgets.removeAt(i);
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                    ],
                                  ));
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.userName.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    snapshot.content.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.w300,
                                            color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text('5d'),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                    SizedBox(
                                      height: 34,
                                      width: 60,
                                      child: TextButton(
                                          onPressed: () {
                                            var commentId =
                                                commentSubId[snapshot];
                                            widget.onReplySelected
                                                ?.call(commentId!);
                                            widget.textEditingController.text =
                                                '@${snapshot.userName} ';
                                          },
                                          style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStatePropertyAll(
                                                      Colors.grey[700])),
                                          child: const Text('Reply')),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return Column(
                  children: commentWidgets,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Container();
            }
          },
        ),
      ],
    );
  }

  PreferredSize avatarChild(context, snapshot) => PreferredSize(
        preferredSize: const Size.fromRadius(12),
        child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(snapshot.avatar.toString())),
      );

  PreferredSize avatarRoot(context, snapshot) => PreferredSize(
        preferredSize: const Size.fromRadius(18),
        child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(snapshot.avatar.toString())),
      );
}

// ignore: file_names
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:coffee/bundle.dart';
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

Future<http.Response> deleteComment(int id, int idBlog) async {
  var commentB = {};
  commentB['id'] = id;
  commentB['idBlog'] = idBlog;
  final response = await http.get(
      Uri.parse(
          '$u/api/Comment/userDeleteCommentBlog?idComment=$id&idBlog=$idBlog'),
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
  List<Widget> widgetsToDisplay = [];
  int? selectedCommentId;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void onReplySelected(int id) {
    setState(() {
      selectedCommentId = id;
    });
  }

  Map<Comment, int> commentMainId = {};
  Map<Comment, int> commentSubId = {};
  Map<Comment, String> commentMainTimestamp = {};
  Map<Comment, String> commentSubTimestamp = {};
  Map<Comment, int> mainTimeSpace = {};
  Map<Comment, int> subTimeSpace = {};

  String checkMainTimeSpace(int mainTimeSpace) {
    if (mainTimeSpace <= 0) {
      return 'Today';
    } else if (mainTimeSpace <= 7) {
      return 'This week';
    } else if (mainTimeSpace <= 30) {
      return 'This month';
    } else {
      return 'This year';
    }
  }

  String checkSubTimeSpace(int subTimeSpace) {
    if (subTimeSpace <= 0) {
      return 'Today';
    } else if (subTimeSpace <= 7) {
      return 'This week';
    } else if (subTimeSpace <= 30) {
      return 'This month';
    } else {
      return 'This year';
    }
  }

  @override
  void initState() {
    super.initState();
    loadComments();
  }

  void loadComments() async {
    try {
      var comments = await fetchAllCommentFromAPI(widget.idBlog);
      setState(() {
        widgetsToDisplay.addAll(buildCommentWidgets(comments));
      });
    } catch (e) {
      e.toString();
    }
  }

  List<Widget> buildCommentWidgets(List<commentBlog> comments) {
    List<Comment> mainComments = [];
    List<List<Comment>> subComments = [];

    for (var commentBlog in comments) {
      var newComment = Comment(
        avatar: commentBlog.userAvatar,
        userName: commentBlog.userName,
        content: commentBlog.comment,
      );
      mainComments.add(newComment);
      commentMainId[newComment] = commentBlog.id!;
      commentMainTimestamp[newComment] = commentBlog.dateCreate.toString();
      mainTimeSpace[newComment] = commentBlog.timeSpace!;

      List<Comment> tempSubComments = [];
      for (var subComment in commentBlog.lsSubComment!) {
        var newSubComment = Comment(
          avatar: subComment.userAvatar,
          userName: subComment.userName,
          content: subComment.comment,
        );
        tempSubComments.add(newSubComment);
        commentSubId[newSubComment] = subComment.id!;
        commentSubTimestamp[newSubComment] = subComment.dateCreate.toString();
        subTimeSpace[newSubComment] = subComment.timeSpace!;
      }
      subComments.add(tempSubComments);
    }

    for (int i = 0; i < mainComments.length; i++) {
      String mainTime = checkMainTimeSpace(mainTimeSpace[mainComments[i]] ?? 0);
      String subTime = checkMainTimeSpace(subTimeSpace[subComments[i]] ?? 0);
      commentWidgets.add(Container(
        key: UniqueKey(),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CommentTreeWidget<Comment, Comment>(
          mainComments[i],
          subComments[i],
          treeThemeData: const TreeThemeData(
              lineColor: Color.fromARGB(255, 233, 229, 229), lineWidth: 2),
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
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                avatarRoot(context, snapshot),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 280,
                                                  child: Form(
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter some text';
                                                        }
                                                        return null;
                                                      },
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
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  editComment(
                                                      widget
                                                          .textEditingController
                                                          .text,
                                                      commentMainId[snapshot]!);
                                                }

                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Blog_Approved_detail(
                                                              comments: const [],
                                                              blog: widget.blog,
                                                            )));
                                              },
                                              child: const Text('Edit'),
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
                                    commentMainId[snapshot]!, widget.idBlog);
                                setState(() {
                                  commentWidgets.removeAt(i);
                                });
                                Navigator.pop(context);
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.userName.toString(),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
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
                              .copyWith(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Text(mainTime),
                          const SizedBox(
                            width: 25,
                          ),
                          SizedBox(
                            height: 34,
                            width: 60,
                            child: TextButton(
                                onPressed: () {
                                  var commentId = commentMainId[snapshot];
                                  widget.onReplySelected?.call(commentId!);
                                  widget.textEditingController.text =
                                      '@${snapshot.userName} ';
                                },
                                style: ButtonStyle(
                                    foregroundColor: MaterialStatePropertyAll(
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
                                      height:
                                          MediaQuery.of(context).size.height,
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                avatarChild(context, snapshot),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  width: 280,
                                                  child: Form(
                                                    key: _formKey,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter some text';
                                                        }
                                                        return null;
                                                      },
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
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  editComment(
                                                      widget
                                                          .textEditingController
                                                          .text,
                                                      commentSubId[snapshot]!);
                                                }

                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Blog_Approved_detail(
                                                              comments: const [],
                                                              blog: widget.blog,
                                                            )));
                                              },
                                              child: const Text('Edit'),
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
                                    commentSubId[snapshot]!, widget.idBlog);
                                setState(() {
                                  commentWidgets.removeAt(i);
                                });
                                Navigator.pop(context);
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                              ?.copyWith(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey[700], fontWeight: FontWeight.bold),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Text(subTime),
                          const SizedBox(
                            width: 24,
                          ),
                          SizedBox(
                            height: 34,
                            width: 60,
                            child: TextButton(
                                onPressed: () {
                                  var commentId = commentSubId[snapshot];
                                  widget.onReplySelected?.call(commentId!);
                                  widget.textEditingController.text =
                                      '@${snapshot.userName} ';
                                },
                                style: ButtonStyle(
                                    foregroundColor: MaterialStatePropertyAll(
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
    return commentWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: commentWidgets,
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

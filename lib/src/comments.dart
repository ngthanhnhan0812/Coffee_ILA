// ignore: file_names
import 'dart:convert';

import 'package:coffee/ip/ip.dart';
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
// var list  = [
// "$u/api/Comment/userViewAllCommentBlog?idBlog=1",
// "$u/api/Comment/userGetCommentBlogM?idBlog=1",
// "$u/api/Comment/userGetSubCommentBlog?idBlog=1"
// ];

//   fetchData() async {
//     final responses = await Future.wait([
//       http.get(Uri.parse('$u/api/Comment/userViewAllCommentBlog?idBlog=1')), // make sure return type of these functions as Future.
//       http.get(Uri.parse('$u/api/Comment/userGetCommentBlogM?idBlog=1')),
//       http.get(Uri.parse('$u/api/Comment/userGetSubCommentBlog?idBlog=1')),
//       ]);
//     var allComment = responses.first;
//     var mainComment =  responses[1];
//     var subComment = responses[2];

// }

class CommentsBlog extends StatefulWidget {
  final int idBlog;
  const CommentsBlog({super.key, required this.idBlog});

  @override
  State<CommentsBlog> createState() => _CommentsState();
}

class _CommentsState extends State<CommentsBlog> {
  bool reply = false;
  late List<commentBlog> comments;
  List<Widget> commentWidgets = [];

  @override
  void initState() {
    super.initState();
    fetchAllCommentFromAPI(widget.idBlog);
    // fetchAllCommentFromAPI(widget.idBlog).then((commentList) {
    //   setState(() {
    //     comments = commentList;
    //   });
    // });
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
            }else{
               for (var commentBlog in snapshot.data as List<commentBlog>) {
              mainComments.add(Comment(
                avatar: commentBlog.userAvatar,
                userName: commentBlog.userName,
                content: commentBlog.comment,
              ));

              List<Comment> tempSubComments = [];
              for (var subComment in commentBlog.lsSubComment!) {
                tempSubComments.add(Comment(
                  avatar: subComment.userAvatar,
                  userName: subComment.userName,
                  content: subComment.comment,
                ));
              }
              subComments.add(tempSubComments);
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
                  avatarRoot: (context, snapshot) => PreferredSize(
                    preferredSize: const Size.fromRadius(18),
                    child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(snapshot.avatar.toString())),
                  ),
                  avatarChild: (context, snapshot) => PreferredSize(
                    preferredSize: const Size.fromRadius(12),
                    child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(snapshot.avatar.toString())),
                  ),
                  contentRoot: (context, snapshot) {
                    return Column(
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
                                      onPressed: () {},
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
                    );
                  },
                  contentChild: (context, snapshot) {
                    return Column(
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
                                      onPressed: () {},
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
}

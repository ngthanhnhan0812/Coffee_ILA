// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee/src/comments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';

import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/blog.dart';
import 'package:coffee/src/edit_blog.dart';
import 'package:coffee/src/models/blog.dart';

// ignore: camel_case_types
class Blog_Approved_detail extends StatefulWidget {
  final Blog blog;
  const Blog_Approved_detail({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<Blog_Approved_detail> createState() => _Blog_detailState();
}

// ignore: camel_case_types
class _Blog_detailState extends State<Blog_Approved_detail> {
  TextEditingController cmt = TextEditingController();
  final data = [1];
  bool c = true;

  @override
  void dispose() {
    cmt.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // getData();
  }

  // getData() async {
  //   List<commentBlog> cmtb = await fetchAllCommentFromAPI(widget.cmtB?.id);
  //   for (int i = 0; i < cmtb.length; i++) {
  //     var b = {};
  //     b["idBlog"] = cmtb[i].idBlog;
  //     b["userName"] = cmtb[i].userName;
  //     b["userAvatar"] = cmtb[i].userAvatar;
  //     b["comment"] = cmtb[i].comment;
  //     itemB.add(b);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  widget.blog.image,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/default-photo.jpg');
                  },
                  fit: BoxFit.cover,
                ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: data.length,
                    (_, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 1,
                                    width: 350,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Description',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 181, 57, 5)),
                                      ),
                                      const VerticalDivider(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Edit_Blog(
                                                          blog: widget.blog)));
                                        },
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 5, 46, 181)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReadMoreText(
                                    widget.blog.description,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    lessStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    color: const Color.fromARGB(255, 245, 245, 245),
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Text(
                        'Comment',
                        style: TextStyle(
                            color: Color.fromARGB(255, 181, 57, 5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      c == true
                          ? CommentsBlog(
                              key: UniqueKey(),
                              idBlog: widget.blog.id,
                            )
                          : Container()
                      // Comments(commentList: commentLi),
                    ],
                  )
                ],
              );
            }))
          ]),
          persistentFooterButtons: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cmt,
                      decoration: InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
          floatingActionButton: SizedBox(
            height: 40,
            width: 40,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 250, 211, 211),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0))),
              onPressed: () {
                Dialog_HideBlog();
              },
              child: const Icon(
                Icons.hide_source_rounded,
                size: 25,
                color: Color.fromARGB(255, 181, 57, 5),
              ),
            ),
          ),
          bottomNavigationBar:
              Padding(padding: EdgeInsets.only(bottom: keyboardHeight))),
    );

    // bottomNavigationBar: AnimatedContainer(
    //   duration: const Duration(milliseconds: 50),
    //   padding: EdgeInsets.only(bottom: keyboardHeight),
    //   child: Container(
    //     height: 50,
    //     padding: const EdgeInsets.all(8),
    //     child: Row(
    //       children: [
    //         Expanded(
    //           child: TextField(
    //             autofocus: true,
    //             controller: cmt,
    //             decoration: InputDecoration(
    //               hintText: '',
    //               border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(15),
    //               ),
    //             ),
    //           ),
    //         ),
    //         IconButton(
    //           icon: const Icon(Icons.send),
    //           onPressed: () {},
    //         ),
    //       ],
    //     ),
    //   ),
    // ));
  }

  // ignore: non_constant_identifier_names
  Future<void> Dialog_HideBlog() async {
    // ignore: unrelated_type_equality_checks
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await hideBlog(widget.blog.id, widget.blog.title, widget.blog.image,
            widget.blog.description, widget.blog.createDate)
        .whenComplete(
      () {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Hidden Blog',
                style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
              ),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Success'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Approve',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlogView(ind: 0)));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Future<http.Response> hideBlog(
    id, title, image, description, createDate) async {
  var p = {};
  p['id'] = id;
  p['title'] = title;
  p['image'] = image;
  p['description'] = description;
  p['createDate'] = createDate;
  p['isStatus'] = 3;
  final response = await http.post(Uri.parse('$u/api/Blog/updateBlog'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(p));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print('Hide blog successfully from The Rest API of blog_detail.dart');
  } else {
    // ignore: avoid_print
    print('Error when updating data in blog_detail.dart');
  }
  return response;
}

// ignore: camel_case_types
class Blog_Waiting_detail extends StatefulWidget {
  final Blog blog;
  const Blog_Waiting_detail({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<Blog_Waiting_detail> createState() => _Blog_Waiting_detailState();
}

// ignore: camel_case_types
class _Blog_Waiting_detailState extends State<Blog_Waiting_detail> {
  final data = [1];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  widget.blog.image,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/default-photo.jpg');
                  },
                  fit: BoxFit.cover,
                ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: data.length,
                    (_, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 1,
                                    width: 350,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Description',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 181, 57, 5)),
                                      ),
                                      const VerticalDivider(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Edit_Blog(
                                                          blog: widget.blog)));
                                        },
                                        child: const Text(
                                          'Edit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 5, 46, 181)),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReadMoreText(
                                    widget.blog.description,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    lessStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }))
          ]),
        ));
  }
}

// ignore: camel_case_types
class Blog_Cancelled_detail extends StatefulWidget {
  final Blog blog;
  const Blog_Cancelled_detail({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<Blog_Cancelled_detail> createState() => _Blog_Cancelled_detailState();
}

// ignore: camel_case_types
class _Blog_Cancelled_detailState extends State<Blog_Cancelled_detail> {
  final data = [1];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  widget.blog.image,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/default-photo.jpg');
                  },
                  fit: BoxFit.cover,
                ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: data.length,
                    (_, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 1,
                                    width: 350,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 181, 57, 5)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReadMoreText(
                                    widget.blog.description,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    lessStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }))
          ]),
        ));
  }
}

// ignore: camel_case_types
class Blog_Hidden_detail extends StatefulWidget {
  final Blog blog;

  const Blog_Hidden_detail({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<Blog_Hidden_detail> createState() => _Blog_Hidden_detailState();
}

// ignore: camel_case_types
class _Blog_Hidden_detailState extends State<Blog_Hidden_detail> {
  TextEditingController cmt = TextEditingController();
  final data = [1];
  bool c = false;
  @override
  void dispose() {
    cmt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          body: CustomScrollView(slivers: [
            SliverAppBar(
                expandedHeight: 250,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                  widget.blog.image,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/default-photo.jpg');
                  },
                  fit: BoxFit.cover,
                ))),
            SliverList(
                delegate: SliverChildBuilderDelegate(childCount: data.length,
                    (_, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 1,
                                    width: 350,
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 181, 57, 5)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ReadMoreText(
                                    widget.blog.description,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    lessStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    color: const Color.fromARGB(255, 245, 245, 245),
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      Text(
                        'Comment',
                        style: TextStyle(
                            color: Color.fromARGB(255, 181, 57, 5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      c == true
                          ? Container()
                          : CommentsBlog(idBlog: widget.blog.id)
                      // Comments(commentList: commentLi),
                    ],
                  )
                ],
              );
            }))
          ]),
        ));
  }

  Future<http.Response> insertMainCommentBlog() async {
    DateTime currentDate = DateTime.now();
    //main
    //iduser, idblog, content, usertype
    var cmtB = {};

    cmtB['idAccount'] = 1;
    cmtB['idBlog'] = widget.blog.id;
    cmtB['comment'] = cmt.text;
    cmtB['userType'] = 1;
    // cmtB['dateCreate'] == currentDate;
    // cmtB['indC'] = 0;
    // cmtB['mnC'] = 0;
    // cmtB['status'] = 1;
    final response = await http.post(
        Uri.parse('$u/api/Comment/userAddNewComment'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(cmtB));

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(
          'Add main comment successfully from The Rest API of blog_detail.dart');
    }
    return response;
  }

  Future<http.Response> insertSubCommentBlog() async {
    DateTime currentDate = DateTime.now();
    //sub 
    //iduser, idblog, content, idreply, usertype, mainc(?)
    var cmtB = {};

    cmtB['idBlog'] = widget.blog.id;
    cmtB['idAccount'] = 5;
    cmtB['comment'] = cmt.text;
    cmtB['dateCreate'] == currentDate;
    cmtB['idReply'] = 5;
    cmtB['indC'] = 0;
    cmtB['mnC'] = 0;
    cmtB['status'] = 1;
    cmtB['userType'] = 1;
    final response = await http.post(
        Uri.parse('$u/api/Comment/userAddNewComment'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(cmtB));

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(
          'Add main comment successfully from The Rest API of blog_detail.dart');
    }
    return response;
  }
}

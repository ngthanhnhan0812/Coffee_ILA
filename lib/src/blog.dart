// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee/src/comments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/models/blog.dart';
import 'package:coffee/src/tes.dart';

List<String> tabName = <String>['Approved', 'Waiting', 'Cancelled', 'Hidden'];

List<Blog> parseBlog(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Blog>((json) => Blog.fromJson(json)).toList();
}

Future<List<Blog>> fetchApprovedBlog() async {
  int id = await getIdSup();
  final response = await http.get(
      Uri.parse('$u/api/Blog/supplierFilterBlog?userCreate=$id&isStatus=1'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseBlog(response.body);
  } else {
    throw Exception('Unable to fetch Blog from the REST API of blog.dart!');
  }
}

Future<List<Blog>> fetchWaitingBlog() async {
  int id = await getIdSup();
  final response = await http.get(
      Uri.parse('$u/api/Blog/supplierFilterBlog?userCreate=$id&isStatus=0'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseBlog(response.body);
  } else {
    throw Exception('Unable to fetch Blog from the REST API of blog.dart!');
  }
}

Future<List<Blog>> fetchCancelledBlog() async {
  int id = await getIdSup();
  final response = await http.get(
      Uri.parse('$u/api/Blog/supplierFilterBlog?userCreate=$id&isStatus=2'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseBlog(response.body);
  } else {
    throw Exception('Unable to fetch Blog from the REST API of blog.dart!');
  }
}

Future<List<Blog>> fetchHiddenBlog() async {
  int id = await getIdSup();
  final response = await http.get(
      Uri.parse('$u/api/Blog/supplierFilterBlog?userCreate=$id&isStatus=3'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseBlog(response.body);
  } else {
    throw Exception('Unable to fetch Blog from the REST API of blog.dart!');
  }
}

// ignore: must_be_immutable
class BlogView extends StatefulWidget {
  int ind;
  BlogView({
    Key? key,
    required this.ind,
  }) : super(key: key);

  @override
  State<BlogView> createState() => _BlogState();
}

class _BlogState extends State<BlogView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const tabsCount = 4;
    return DefaultTabController(
      initialIndex: widget.ind,
      length: tabsCount,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Dashboard()));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          centerTitle: true,
          title: const Text(
            "BLOG",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          // style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)
          bottom: TabBar(
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 181, 57, 5)),
              ),
              labelStyle:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              labelColor: const Color.fromARGB(255, 181, 57, 5),
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              tabs: <Widget>[
                Tab(
                    child: Text(
                  tabName[0],
                )),
                Tab(
                    child: Text(
                  tabName[1],
                )),
                Tab(
                    child: Text(
                  tabName[2],
                )),
                Tab(
                    child: Text(
                  tabName[3],
                ))
              ]),
        ),
        body: const TabBarView(
          children: [
            Blog_Approved(),
            Blog_Waiting(),
            Blog_Cancelled(),
            Blog_Hidden()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: 50,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Dashboard()));
                  },
                  child: const Icon(
                    Icons.home,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Myproduct(initialPage: 0)));
                  },
                  child: const Icon(
                    Icons.view_cozy,
                    color: Colors.grey,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: const Icon(
                    Icons.leaderboard,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Marketing(
                              containSelectedBox: [],
                            )));
                  },
                  child: const Icon(
                    Icons.api_sharp,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlogView(ind: 0)));
                  },
                  child: const Icon(
                    Icons.app_registration,
                    color: Color.fromARGB(255, 181, 57, 5),
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: SizedBox(
          height: 40,
          width: 40,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 250, 211, 211),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewBlog()),
              );
            },
            child: const Icon(
              Icons.add,
              size: 25,
              color: Color.fromARGB(255, 181, 57, 5),
            ),
          ),
        ),
      ),
    );
  }

// ignore: unused_element
  Future<void> _refresh() {
    return Future.delayed(const Duration(seconds: 1));
  }
}

// ignore: camel_case_types
class Blog_Approved extends StatefulWidget {
  const Blog_Approved({super.key});

  @override
  State<Blog_Approved> createState() => Blog_ApprovedState();
}

// ignore: camel_case_types
class Blog_ApprovedState extends State<Blog_Approved> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder<List<Blog>>(
          future: fetchApprovedBlog(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                              onTap: () async {
                                var comments = await fetchAllCommentFromAPI(
                                    snapshot.data![index].id);
                                // ignore: use_build_context_synchronously
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Blog_Approved_detail(
                                                blog: snapshot.data![index],
                                                comments: comments)));
                              },
                              child: GridTile(
                                footer: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 8.0),
                                  color: Colors.black54,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data![index]
                                            .title, // Your item title
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        snapshot.data![index].createDate
                                            .toString(), // Your item subtitle
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/default-photo.jpg');
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// ignore: camel_case_types
class Blog_Waiting extends StatefulWidget {
  const Blog_Waiting({super.key});

  @override
  State<Blog_Waiting> createState() => BlogWaitingState();
}

class BlogWaitingState extends State<Blog_Waiting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder<List<Blog>>(
          future: fetchWaitingBlog(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Blog_Waiting_detail(
                                            blog: snapshot.data![index],
                                          )),
                                );
                              },
                              child: GridTile(
                                footer: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 8.0),
                                  color: Colors.black54,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data![index]
                                            .title, // Your item title
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        snapshot.data![index].createDate
                                            .toString(), // Your item subtitle
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/default-photo.jpg');
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              // ignore: avoid_print
              print(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// ignore: camel_case_types
class Blog_Cancelled extends StatelessWidget {
  const Blog_Cancelled({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: FutureBuilder<List<Blog>>(
          future: fetchCancelledBlog(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: Column(
                    children: [
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Blog_Cancelled_detail(
                                            blog: snapshot.data![index],
                                          )),
                                );
                              },
                              child: GridTile(
                                footer: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 8.0),
                                  color: Colors.black54,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data![index]
                                            .title, // Your item title
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        snapshot.data![index].createDate
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                                child: Image.network(
                                  snapshot.data![index].image,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                        'assets/images/default-photo.jpg');
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('snapshot.error.toString()');
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// ignore: camel_case_types
class Blog_Hidden extends StatelessWidget {
  const Blog_Hidden({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Blog>>(
        future: fetchHiddenBlog(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Blog_Hidden_detail(
                                          blog: snapshot.data![index],
                                        )),
                              );
                            },
                            child: GridTile(
                              footer: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8.0),
                                color: Colors.black54,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data![index]
                                          .title, // Your item title
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      snapshot.data![index].createDate
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              child: Image.network(
                                snapshot.data![index].image,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                      'assets/images/default-photo.jpg');
                                },
                                fit: BoxFit.cover,
                              ),
                            ));
                      },
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('snapshot.error.toString()');
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

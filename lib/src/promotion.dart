// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:coffee/src/blog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/models/discount.dart';

List<String> tabName = <String>['Upcoming', 'In progress', 'Ended'];

List<Discount> parseDiscount(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Discount>((json) => Discount.fromJson(json)).toList();
}

Future<List<Discount>> fetchUpComingDiscount() async {
  final response =
      await http.get(Uri.parse('$u/api/Discount/FilterDiscount1?idSupplier=1'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseDiscount(response.body);
  } else {
    throw Exception(
        'Unable to fetch DISCOUNT from the REST API of promotion.dart!');
  }
}

Future<List<Discount>> fetchInProgressDiscount() async {
  final response =
      await http.get(Uri.parse('$u/api/Discount/FilterDiscount2?idSupplier=1'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseDiscount(response.body);
  } else {
    throw Exception(
        'Unable to fetch DISCOUNT from the REST API of promotion.dart!');
  }
}

Future<List<Discount>> fetchHasDoneDiscount() async {
  final response =
      await http.get(Uri.parse('$u/api/Discount/FilterDiscount3?idSupplier=1'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseDiscount(response.body);
  } else {
    throw Exception(
        'Unable to fetch DISCOUNT from the REST API of promotion.dart!');
  }
}

Future<http.Response> updateDiscountToEnd(
    id, discount, dateBegin, idProduct) async {
  var dsc = {};
  dsc['id'] = id;
  dsc['discount'] = discount;
  dsc['dateBegin'] = dateBegin;
  dsc['idProduct'] = idProduct;
  dsc['dateEnd'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
  dsc['isStatus'] = 2;
  final response = await http.post(Uri.parse('$u/api/Discount/UpdateDiscount'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(dsc));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print('Update Discount successfully from The Rest API of promotion.dart');
  } else {
    // ignore: avoid_print
    print('Error when updating data in promotion.dart');
  }
  return response;
}

// ignore: must_be_immutable
class Promotion extends StatefulWidget {
  int ind;
  Promotion({
    Key? key,
    required this.ind,
  }) : super(key: key);
  @override
  State<Promotion> createState() => _Promotion();
}

// ignore: camel_case_types
class _Promotion extends State<Promotion> {
  @override
  Widget build(BuildContext context) {
    const tabsCount = 3;
    return DefaultTabController(
      initialIndex: widget.ind,
      length: tabsCount,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Marketing(
                          containSelectedBox: [],
                        )));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          centerTitle: true,
          title: const Text(
            "PROMOTION",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          // style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)
          bottom: TabBar(
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 3, color: Color.fromARGB(255, 181, 57, 5)),
              ),
              labelStyle:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                ))
              ]),
        ),
        body: const TabBarView(
          children: [
            Upcoming(),
            InProgress(),
            Ended(),
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ));
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
                    color: Color.fromARGB(255, 181, 57, 5),
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
                    color: Colors.grey,
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
                MaterialPageRoute(builder: (context) => const NewPromotion()),
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
}

class Upcoming extends StatefulWidget {
  const Upcoming({
    super.key,
  });

  @override
  State<Upcoming> createState() => UpComingState();
}

class UpComingState extends State<Upcoming> {
  bool isDelete = false;
  Future<http.Response> deleteDiscount(int id) async {
    setState(() {});

    var discount = {};
    discount['id'] = id;
    final response =
        await http.post(Uri.parse('$u/api/Discount/DeleteDiscountNew?id=$id'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(discount));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Delete discount successfully!');
    } else {
      // ignore: avoid_print
      print(
          'Failed to delete Discount: ${response.statusCode}\t ${response.body}');
    }
    // ignore: unused_element

    return response;
  }

  Future<void> deleteDialog(int id) async {
    if (isDelete = false) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Delete',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Failed to delete discount'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      try {
        await Future.delayed(const Duration(seconds: 2));
      } finally {
        setState(() {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text(
                      'Delete discount',
                      style: TextStyle(color: Color.fromARGB(255, 43, 32, 28)),
                    ),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Delete discount successfully!'),
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
                          Navigator.pop(context);
                        },
                      ),
                    ]);
              });
        });
        setState(() {
          isDelete = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(0),
          child: FutureBuilder<List<Discount>>(
            future: fetchUpComingDiscount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, int index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => Blog_Approved_detail(
                              //             blog: snapshot.data![index],
                              //           )),
                              // );
                            },
                            child: Container(
                              color: Colors.white,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            image: const DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/pngtree-price-tag-with-the-discount-icon-vector-png-image_6686659.png?alt=media&token=2181c43b-7352-4ed1-8fd9-fc6adc9effc0&_gl=1*1lblhks*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5Nzc4NzcyNi44MC4xLjE2OTc3ODc5MTEuNjAuMC4w'),
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                DateFormat('yyyy/MM/dd').format(
                                                    DateTime.parse(snapshot
                                                        .data![index].dateBegin
                                                        .toString())),
                                                style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const Text(' - '),
                                              Text(
                                                DateFormat('yyyy/MM/dd').format(
                                                    DateTime.parse(snapshot
                                                        .data![index].dateEnd
                                                        .toString())),
                                                style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 19,
                                              ),
                                              Text('Up Coming',
                                                  style: GoogleFonts.openSans(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .blue))),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Discount: ${snapshot.data![index].discount}',
                                                    // '',
                                                    style:
                                                        GoogleFonts.openSans(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Container(
                                                height: 40,
                                                width: 1,
                                                color: const Color.fromARGB(
                                                    255, 167, 167, 167),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Edit_Promotion(
                                                                    discount: snapshot
                                                                            .data![
                                                                        index])));
                                                  },
                                                  icon: const Icon(
                                                    Icons.edit_note_outlined,
                                                    color: Color.fromARGB(
                                                        255, 148, 148, 148),
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await deleteDiscount(
                                                      snapshot.data![index].id);
                                                  deleteDialog(
                                                      snapshot.data![index].id);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 181, 57, 5),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),

                                                      // <-- Radius
                                                    ),
                                                    minimumSize:
                                                        const Size(70, 30)),
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255)),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    width: 380,
                                    color: Colors.grey.shade200,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }
}

class InProgress extends StatefulWidget {
  const InProgress({
    super.key,
  });

  @override
  State<InProgress> createState() => InProgressState();
}

class InProgressState extends State<InProgress> {
  bool isEnd = false;
  // ignore: non_constant_identifier_names
  Future<void> EndDiscount_Dialog(int id) async {
    if (isEnd = false) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Update',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Failed to update discount'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      try {
        await Future.delayed(const Duration(seconds: 2));
      } finally {
        setState(() {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text(
                      'Update discount',
                      style: TextStyle(color: Color.fromARGB(255, 43, 32, 28)),
                    ),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Update discount successfully!'),
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
                          Navigator.pop(context);
                        },
                      ),
                    ]);
              });
        });
        setState(() {
          isEnd = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<List<Discount>>(
            future: fetchInProgressDiscount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           Blog_Approved_detail(
                                //             blog: snapshot.data![index],
                                //           )),
                                // );
                              },
                              child: Container(
                                color: Colors.white,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              image: const DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/pngtree-price-tag-with-the-discount-icon-vector-png-image_6686659.png?alt=media&token=2181c43b-7352-4ed1-8fd9-fc6adc9effc0&_gl=1*1lblhks*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5Nzc4NzcyNi44MC4xLjE2OTc3ODc5MTEuNjAuMC4w'),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data![index].dateBegin,
                                                  style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const Text(' - '),
                                                Text(
                                                  snapshot.data![index].dateEnd,
                                                  style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text('In progress',
                                                    style: GoogleFonts.openSans(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .green))),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Discount: ${snapshot.data![index].discount}',
                                                  // '',
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 40,
                                                  width: 1,
                                                  color: const Color.fromARGB(
                                                      255, 167, 167, 167),
                                                ),
                                                const SizedBox(
                                                  width: 80,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    updateDiscountToEnd(
                                                      snapshot.data![index].id,
                                                      snapshot.data![index]
                                                          .discount,
                                                      snapshot.data![index]
                                                          .dateBegin,
                                                      snapshot.data![index]
                                                          .idProduct,
                                                    );
                                                    EndDiscount_Dialog(snapshot
                                                        .data![index].id);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          backgroundColor:
                                                              const Color
                                                                  .fromARGB(255,
                                                                  181, 57, 5),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),

                                                            // <-- Radius
                                                          ),
                                                          minimumSize:
                                                              const Size(
                                                                  70, 30)),
                                                  child: const Text(
                                                    'End soon',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            255,
                                                            255,
                                                            255)),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 1,
                                      width: 380,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
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
      ),
    );
  }
}

class Ended extends StatefulWidget {
  // final Product product;
  const Ended({
    Key? key,
    // required this.product,
  }) : super(key: key);

  @override
  State<Ended> createState() => EndedState();
}

class EndedState extends State<Ended> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<List<Discount>>(
            future: fetchHasDoneDiscount(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int index) {
                            return InkWell(onTap: () {
                              //   if (widget.product.id ==
                              //       snapshot.data![index].idProduct) {
                              //     showModalBottomSheet(
                              //         context: context,
                              //         builder: (BuildContext context) {
                              //           return Container(
                              //             height: 200,
                              //             // color: Colors.white,
                              //             margin: const EdgeInsets.fromLTRB(
                              //                 5, 5, 5, 0),
                              //             child: Column(
                              //               children: [
                              //                 const SizedBox(height: 50),
                              //                 Row(
                              //                   children: [
                              //                     Container(
                              //                       width: 80,
                              //                       height: 80,
                              //                       decoration: BoxDecoration(
                              //                           borderRadius:
                              //                               BorderRadius
                              //                                   .circular(7),
                              //                           image: DecorationImage(
                              //                             fit: BoxFit.fill,
                              //                             image: NetworkImage(
                              //                                 widget.product
                              //                                     .image),
                              //                           )),
                              //                     ),
                              //                     const SizedBox(
                              //                       width: 10,
                              //                     ),
                              //                     Column(
                              //                       mainAxisAlignment:
                              //                           MainAxisAlignment.start,
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: [
                              //                         Row(
                              //                           children: [
                              //                             Text(
                              //                               widget
                              //                                   .product.title,
                              //                               style: GoogleFonts
                              //                                   .openSans(
                              //                                 textStyle: const TextStyle(
                              //                                     fontWeight:
                              //                                         FontWeight
                              //                                             .bold),
                              //                               ),
                              //                             ),
                              //                             const SizedBox(
                              //                               width: 19,
                              //                             ),
                              //                           ],
                              //                         ),
                              //                         const SizedBox(
                              //                           height: 10,
                              //                         ),
                              //                         Row(
                              //                           children: [
                              //                             Column(
                              //                               mainAxisAlignment:
                              //                                   MainAxisAlignment
                              //                                       .start,
                              //                               crossAxisAlignment:
                              //                                   CrossAxisAlignment
                              //                                       .start,
                              //                               children: [
                              //                                 Text(
                              //                                   widget.product
                              //                                       .price
                              //                                       .toString(),
                              //                                   // '',
                              //                                   style: GoogleFonts
                              //                                       .openSans(),
                              //                                 ),
                              //                               ],
                              //                             ),
                              //                           ],
                              //                         )
                              //                       ],
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 const SizedBox(
                              //                   height: 10,
                              //                 ),
                              //                 Container(
                              //                   height: 1,
                              //                   width: 380,
                              //                   color: Colors.grey.shade200,
                              //                 ),
                              //                 const SizedBox(
                              //                   height: 10,
                              //                 ),
                              //               ],
                              //             ),
                              //           );
                              //         });
                              //   }
                              // },
                              // ignore: unnecessary_null_comparison
                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              image: const DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/pngtree-price-tag-with-the-discount-icon-vector-png-image_6686659.png?alt=media&token=2181c43b-7352-4ed1-8fd9-fc6adc9effc0&_gl=1*1lblhks*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5Nzc4NzcyNi44MC4xLjE2OTc3ODc5MTEuNjAuMC4w'),
                                              )),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data![index].dateBegin,
                                                  style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const Text(' - '),
                                                Text(
                                                  snapshot.data![index].dateEnd,
                                                  style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text('Ended',
                                                    style: GoogleFonts.openSans(
                                                        textStyle:
                                                            const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey))),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Discount: ${snapshot.data![index].discount}',
                                                  // '',
                                                  style: GoogleFonts.openSans(),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 1,
                                      width: 380,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            });
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
      ),
    );
  }
}
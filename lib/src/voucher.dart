import 'dart:convert';

import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/blog.dart';
import 'package:intl/intl.dart';
import 'models/voucher.dart';
import 'package:coffee/bundle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

List<String> titles = <String>[
  'Up Coming',
  'Online',
  'Done',
];

List<Voucher> parseVoucher(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Voucher>((json) => Voucher.fromJson(json)).toList();
}

Future<List<Voucher>> fetchVoucher() async {
  final response = await http.get(Uri.parse(
      '$u/api/Voucher/supplierGetAllVoucher?userCreate=ADMIN&isActive=1'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseVoucher(response.body);
  } else {
    throw Exception(
        'Unable to fetch VOUCHER from the REST API of Voucher.dart!');
  }
}

Future<List<Voucher>> fetchVoucherIsUpComing() async {
  final response = await http.get(
      Uri.parse('$u/api/Voucher/supplierFilterVoucher00?userCreate=ADMIN'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseVoucher(response.body);
  } else {
    throw Exception(
        'Unable to fetch VOUCHER from the REST API of Voucher.dart!');
  }
}

Future<List<Voucher>> fetchVoucherIsOnline() async {
  final response = await http.get(
      Uri.parse('$u/api/Voucher/supplierFilterVoucher01?userCreate=ADMIN'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseVoucher(response.body);
  } else {
    throw Exception(
        'Unable to fetch VOUCHER from the REST API of Voucher.dart!');
  }
}

Future<List<Voucher>> fetchVoucherHasDone() async {
  final response = await http.get(
      Uri.parse('$u/api/Voucher/supplierFilterVoucher02?userCreate=ADMIN'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseVoucher(response.body);
  } else {
    throw Exception(
        'Unable to fetch VOUCHER from the REST API of Voucher.dart!');
  }
}

Future<http.Response> updateVoucherToEnd(
    id, condition, discount, usercreate, startDate) async {
  var vo = {};
  vo['id'] = id;
  vo['condition'] = condition;
  vo['discount'] = discount;
  vo['usercreate'] = usercreate;
  vo['startDate'] = startDate;
  vo['endDate'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
  vo['isActive'] = 2;
  final response = await http.post(Uri.parse('$u/api/Voucher/updateVoucher'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(vo));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print('Update Voucher successfully from The Rest API of voucher.dart');
  } else {
    // ignore: avoid_print
    print('Error when updating data in edit_voucher.dart');
  }
  return response;
}

// ignore: camel_case_types, must_be_immutable
class Voucher_home extends StatefulWidget {
  int ind;
  Voucher_home({super.key, required this.ind});
  @override
  State<Voucher_home> createState() => _Voucher_home();
}

// ignore: camel_case_types
class _Voucher_home extends State<Voucher_home> {
  @override
  Widget build(BuildContext context) {
    const int tabsCount = 3;
    return DefaultTabController(
      initialIndex: widget.ind,
      length: tabsCount,
      child: Scaffold(
        backgroundColor: Colors.white,
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
            "MY VOUCHER",
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
                  titles[0],
                )),
                Tab(
                    child: Text(
                  titles[1],
                )),
                Tab(
                    child: Text(
                  titles[2],
                ))
              ]),
        ),
        body: const TabBarView(
          children: [
            SingleChildScrollView(child: UpComing_Voucher()),
            SingleChildScrollView(child: Active_Voucher()),
            SingleChildScrollView(child: Ended_Voucher())
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
                MaterialPageRoute(builder: (context) => const NewVoucher()),
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

// ignore: camel_case_types
class UpComing_Voucher extends StatefulWidget {
  const UpComing_Voucher({super.key});

  @override
  State<UpComing_Voucher> createState() => _UpComing_Voucher();
}

// ignore: camel_case_types
class _UpComing_Voucher extends State<UpComing_Voucher> {
  bool isDelete = false;
  Future<http.Response> deleteVoucher(String id) async {
    setState(() {});

    var voucher = {};
    voucher['id'] = id;
    final response =
        await http.post(Uri.parse('$u/api/Voucher/deleteVoucher?id=$id'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(voucher));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Delete voucher successfully!');
    } else {
      print(
          'Failed to delete Voucher: ${response.statusCode}\t ${response.body}');
    }
    // ignore: unused_element

    return response;
  }

  Future<void> deleteDialog(String id) async {
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
                  Text('Failed to delete voucher'),
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
                      'Delete voucher',
                      style: TextStyle(color: Color.fromARGB(255, 43, 32, 28)),
                    ),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Delete voucher successfully!'),
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

  Future<void> refresh() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      fetchUpComingDiscount();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<List<Voucher>>(
          future: fetchVoucherIsUpComing(),
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
                        return Container(
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
                                        borderRadius: BorderRadius.circular(7),
                                        image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/voucher-black-friday-related-filled-icon-vector-28114495%20(1).jpg?alt=media&token=e4033924-00dd-4ae2-95a0-3b3241913755&_gl=1*nd2x0w*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5Nzc4NzcyNi44MC4xLjE2OTc3ODc4NTkuMzIuMC4w'),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            DateFormat('yyyy/MM/dd').format(
                                                DateTime.parse(snapshot
                                                    .data![index].startDate
                                                    .toString())),
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Text(' - '),
                                          Text(
                                            DateFormat('yyyy/MM/dd').format(
                                                DateTime.parse(snapshot
                                                    .data![index].endDate
                                                    .toString())),
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 19,
                                          ),
                                          Text('Up Coming',
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue))),
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
                                                style: GoogleFonts.openSans(),
                                              ),
                                              Text(
                                                'Condition: ${snapshot.data![index].condition}',
                                                // '',
                                                style: GoogleFonts.openSans(),
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
                                                            EditVoucher(
                                                                voucher: snapshot
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
                                              await deleteVoucher(
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
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),

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
                        );
                      })
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}

// ignore: camel_case_types
class Active_Voucher extends StatefulWidget {
  const Active_Voucher({
    super.key,
  });

  @override
  State<Active_Voucher> createState() => _Active_Voucher();
}

// ignore: camel_case_types
class _Active_Voucher extends State<Active_Voucher> {
  bool isEnd = false;
  // ignore: non_constant_identifier_names
  Future<void> EndVoucher_Dialog(String id) async {
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
                  Text('Failed to update voucher'),
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
                      'Update voucher',
                      style: TextStyle(color: Color.fromARGB(255, 43, 32, 28)),
                    ),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Update voucher successfully!'),
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
    return Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<List<Voucher>>(
          future: fetchVoucherIsOnline(),
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
                        return Container(
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
                                        borderRadius: BorderRadius.circular(7),
                                        image: const DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/voucher-black-friday-related-filled-icon-vector-28114495%20(1).jpg?alt=media&token=e4033924-00dd-4ae2-95a0-3b3241913755&_gl=1*nd2x0w*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5Nzc4NzcyNi44MC4xLjE2OTc3ODc4NTkuMzIuMC4w'),
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data![index].startDate,
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const Text(' - '),
                                          Text(
                                            snapshot.data![index].endDate,
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text('Online',
                                              style: GoogleFonts.openSans(
                                                  textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green))),
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
                                                style: GoogleFonts.openSans(),
                                              ),
                                              Text(
                                                'Condition: ${snapshot.data![index].condition}',
                                                // '',
                                                style: GoogleFonts.openSans(),
                                              ),
                                            ],
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
                                            width: 60,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              updateVoucherToEnd(
                                                  snapshot.data![index].id,
                                                  snapshot
                                                      .data![index].condition,
                                                  snapshot
                                                      .data![index].discount,
                                                  snapshot
                                                      .data![index].usercreate,
                                                  snapshot
                                                      .data![index].startDate);
                                              EndVoucher_Dialog(
                                                  snapshot.data![index].id);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 181, 57, 5),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                minimumSize:
                                                    const Size(70, 30)),
                                            child: const Text(
                                              'End soon',
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
                        );
                      })
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  void showLoadingDialog(BuildContext context, VoidCallback onDismissed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Voucher_home(ind: 1)));
      onDismissed();
    });
  }
}

// ignore: camel_case_types
class Ended_Voucher extends StatefulWidget {
  const Ended_Voucher({
    super.key,
  });

  @override
  State<Ended_Voucher> createState() => _Ended_Voucher();
}

// ignore: camel_case_types
class _Ended_Voucher extends State<Ended_Voucher> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: FutureBuilder<List<Voucher>>(
            future: fetchVoucherHasDone(),
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
                          return Container(
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
                                                'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/voucher-black-friday-related-filled-icon-vector-28114495%20(1).jpg?alt=media&token=e4033924-00dd-4ae2-95a0-3b3241913755&_gl=1*nd2x0w*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5Nzc4NzcyNi44MC4xLjE2OTc3ODc4NTkuMzIuMC4w'),
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
                                              snapshot.data![index].startDate,
                                              style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const Text(' - '),
                                            Text(
                                              snapshot.data![index].startDate,
                                              style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text('Done',
                                                style: GoogleFonts.openSans(
                                                    textStyle: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey))),
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
                                                  style: GoogleFonts.openSans(),
                                                ),
                                                Text(
                                                  'Condition: ${snapshot.data![index].condition}',
                                                  // '',
                                                  style: GoogleFonts.openSans(),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
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
                        })
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
// import 'package:coffee/src/search_Prod_discount.dart';

class FetchProduct {
  // ignore: non_constant_identifier_names
  List<Product> parse_prodProduct(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  var data = [];
  List<Product> results = [];

  // ignore: non_constant_identifier_names
  Future<List<Product>> fetch_prodProduct({String? query}) async {
    var id = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Supplier/Products/GetAllProdNotHaveDiscount?idSupplier=$id'));
    // ignore: avoid_print
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        List<Product> vv = [];
        List<Product> vvv = [];
        if (vietpr.length != 0) {
          for (var e in vietpr) {
            vv.add(e);
          }
        }
        if (vietpro.length != 0) {
          for (var e in vietpro) {
            vv.add(e);
          }
        }
        data = json.decode(response.body);
        results = data.map((e) => Product.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.title.toLowerCase().startsWith(query.toLowerCase()))
              .toList();
        }
        if (vv.length != 0) {
          for (var b in vv) {
            results.removeWhere((element) => element.id == b.id);
          }
        }
        if (vvv.length != 0) {
          for (var z in vv) {
            results.removeWhere((element) => element.id == z.id);
          }
        }
      } else {
        throw Exception(
            'Unable to fetch product from the REST API of new_prod_discount.dart!');
      }
    } on Exception catch (e) {
      print('error at $e');
    }

    return results;
  }
}

// ignore: camel_case_types
class New_Prod_Product extends StatefulWidget {
  New_Prod_Product({
    Key? key,
  }) : super(key: key);

  @override
  State<New_Prod_Product> createState() => _New_Prod_Product();
}

// ignore: camel_case_types
class _New_Prod_Product extends State<New_Prod_Product> {
  FetchProduct productList = FetchProduct();
  // ignore: non_constant_identifier_names
  final List<int> _selected_Prod = [];
  bool isAllSelected = false;
  List<Product>? productListData;
  int _counter = 0;

  final _formKey = GlobalKey<FormState>();
  List<Product> containSelectedBox = [];

  void incCounter() {
    setState(() {
      _counter++;
    });
  }

  void descCounter() {
    setState(() {
      _counter--;
    });
  }

  void setCounter() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 203, 203, 203),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          'Add Product',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 181, 57, 5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: const[
          // IconButton(
          //   icon: const Icon(Icons.search),
          //   tooltip: 'Open search future',
          //   onPressed: () {
          //     showSearch(context: context, delegate: SearchProduct());
          //   },
          // ),
        ],
      ),
      // body: fakeViewData(),
      body: getProductSupplier(),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Row(children: [
                Checkbox(
                  value: isAllSelectedCheck(),
                  onChanged: (value) {
                    setState(() {
                      isAllSelected = value!;
                      if (isAllSelected) {
                        _selected_Prod.clear();
                        containSelectedBox.clear();
                        for (var product in productListData!) {
                          _selected_Prod.add(product.id);
                          containSelectedBox.add(product);
                        }
                        _counter = _selected_Prod.length;
                      } else {
                        _selected_Prod.clear();
                        containSelectedBox.clear();
                        _counter = 0;
                      }
                    });
                  },
                ),
                const Text(
                  "Select All",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            const VerticalDivider(
                thickness: 0, color: Color.fromARGB(255, 244, 243, 243)),
            Expanded(
                child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context, containSelectedBox);
                }
              },
              child: Text('Submit',
                  style: GoogleFonts.openSans(color: Colors.white),
                  textAlign: TextAlign.center),
            ))
          ],
        )
      ],
    );
  }

  getProductSupplier() {
    return Stack(
      children: [
        Positioned(
            left: 0,
            top: 10,
            width: 360,
            height: 22,
            child: Center(
                child: Text(
              'Selected: $_counter',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ))),
        Positioned.fill(
            top: 35,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: FutureBuilder<List<Product>>(
                        future: productList.fetch_prodProduct(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            productListData = snapshot.data;
                            return Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, int index) {
                                      return Column(children: [
                                        Row(children: [
                                          Checkbox(
                                              value: _selected_Prod.contains(
                                                  snapshot.data![index].id),
                                              onChanged: (value) {
                                                if (_selected_Prod.contains(
                                                    snapshot.data![index].id)) {
                                                  setState(() {
                                                    for (int i = 0;
                                                        i <
                                                            containSelectedBox
                                                                .length;
                                                        i++) {
                                                      if (containSelectedBox[i]
                                                              .id ==
                                                          snapshot.data![index]
                                                              .id) {
                                                        containSelectedBox.remove(
                                                            containSelectedBox[
                                                                i]);
                                                        descCounter();
                                                      }
                                                    }
                                                    _selected_Prod.remove(
                                                        snapshot
                                                            .data![index].id);
                                                  });
                                                } else {
                                                  setState(() {
                                                    _selected_Prod.add(snapshot
                                                        .data![index].id);
                                                    containSelectedBox.add(
                                                        snapshot.data![index]);
                                                    incCounter();
                                                  });
                                                }
                                              }),
                                          const VerticalDivider(width: 5),
                                          Column(
                                            children: [
                                              SizedBox(
                                                width: 90,
                                                height: 90,
                                                child: Image.network(
                                                  snapshot.data![index].image,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                        'assets/images/default-photo.jpg');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const VerticalDivider(width: 10),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    // softWrap: true,
                                                    // maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    snapshot.data![index].title
                                                                .length >
                                                            20
                                                        ? '${snapshot.data![index].title.substring(0, 23)}...'
                                                        : snapshot
                                                            .data![index].title,
                                                    style: GoogleFonts.openSans(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Row(
                                                children: [
                                                  Text(
                                                    ' ',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$${snapshot.data![index].price}',
                                                    style:
                                                        GoogleFonts.openSans(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ]),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ]);
                                    }),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        })),
              ),
            ))
      ],
    );
  }

  bool isAllSelectedCheck() {
    if (productListData == null) return false;
    return _selected_Prod.length == productListData!.length;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/search_Prod_discount.dart';

class FetchProduct {
  // ignore: non_constant_identifier_names
  List<Product> parse_prodProduct(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  var data = [];
  List<Product> results = [];
// ignore: non_constant_identifier_names
  Future<List<Product>> fetch_prodProduct({String? query, idSup}) async {
    final response = await http.get(Uri.parse(
        '$u/api/Supplier/Products/GetAllProdNotHaveDiscount?idSupplier=1'));
    // ignore: avoid_print
    // print(response.body);
    try {
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => Product.fromJson(e)).toList();
        if (query != null) {
          results = results
              .where((element) =>
                  element.title.toLowerCase().startsWith(query.toLowerCase()))
              .toList();
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
  const New_Prod_Product({
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Open search future',
            onPressed: () {
              showSearch(context: context, delegate: SearchProduct());
            },
          ),
        ],
      ),
      // body: fakeViewData(),
      body: getProductSupplier(),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Row(children: [
                Text('$_counter'),
                const VerticalDivider(
                    color: Color.fromARGB(255, 244, 243, 243)),
                const Text('Selected')
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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.only(left: 8),
            child: FutureBuilder<List<Product>>(
                future: productList.fetch_prodProduct(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, int index) {
                              return Column(children: [
                                Row(children: [
                                  Checkbox(
                                      value: _selected_Prod
                                          .contains(snapshot.data![index].id),
                                      onChanged: (value) {
                                        if (_selected_Prod.contains(
                                            snapshot.data![index].id)) {
                                          setState(() {
                                            for (int i = 0;
                                                i < containSelectedBox.length;
                                                i++) {
                                              if (containSelectedBox[i].id ==
                                                  snapshot.data![index].id) {
                                                containSelectedBox.remove(
                                                    containSelectedBox[i]);
                                                descCounter();
                                              }
                                            }
                                            _selected_Prod.remove(
                                                snapshot.data![index].id);
                                          });
                                        } else {
                                          setState(() {
                                            _selected_Prod
                                                .add(snapshot.data![index].id);
                                            containSelectedBox
                                                .add(snapshot.data![index]);
                                            incCounter();
                                          });
                                        }
                                        // if (containSelectedBox[index].price <
                                        //     widget.discount.discount) {
                                        //   return 'Product must be lower than Discount!';
                                        // }
                                      }),
                                  const VerticalDivider(width: 5),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: 90,
                                        height: 90,
                                        child: Image.network(
                                            snapshot.data![index].image),
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
                                            overflow: TextOverflow.ellipsis,
                                            snapshot.data![index].title.length >
                                                    20
                                                ? '${snapshot.data![index].title.substring(0, 23)}...'
                                                : snapshot.data![index].title,
                                            style: GoogleFonts.openSans(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold),
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
                                            style: GoogleFonts.openSans(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ])
                              ]);
                            })
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Center(child: CircularProgressIndicator());
                })),
      ),
    );
  }

  // CheckboxListTile checkboxlisttile(
  //     AsyncSnapshot<List<Product>> snapshot, int index) {
  //   return CheckboxListTile(
  //     controlAffinity: ListTileControlAffinity.leading,
  //     contentPadding: EdgeInsets.zero,
  //     dense: true,
  //     secondary: ConstrainedBox(
  //       constraints: const BoxConstraints(
  //         minWidth: 60,
  //         minHeight: 60,
  //         maxWidth: 100,
  //         maxHeight: 100,
  //       ),
  //       child: Image.network(snapshot.data![index].image, fit: BoxFit.cover),
  //     ),
  //     title: Text(snapshot.data![index].title, maxLines: 2),
  //     subtitle: Text('\$${snapshot.data![index].price}'),
  //     value: _selected_Prod.contains(productList.data[index].id),
  //     onChanged: (bool? _ischecked) {},
  //   );
  // }
}

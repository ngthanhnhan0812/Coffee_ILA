// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:convert';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:coffee/src/models/discount.dart';

List<Product> vietpro = [];

class UpdateData {
  Discount discount;
  List<Product> products;

  UpdateData({required this.discount, required this.products});
}

// ignore: camel_case_types, must_be_immutable
class Edit_Promotion extends StatefulWidget {
  List<Discount> discount;
  Edit_Promotion({
    Key? key,
    required this.discount,
  }) : super(key: key);

  @override
  State<Edit_Promotion> createState() => _Edit_PromotionState();
}

// ignore: camel_case_types
class _Edit_PromotionState extends State<Edit_Promotion> {
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();
  TextEditingController _discount = TextEditingController();
  // Map<int, Discount> lsProductDis = {};
  List<Product> displayedProducts = [];
  @override
  void initState() {
    super.initState();
    // if (widget.discount.isNotEmpty) {
    firstDate = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(
            DateTime.parse(widget.discount.firstOrNull!.dateBegin.toString())));
    lastDate = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(
            DateTime.parse(widget.discount.firstOrNull!.dateEnd.toString())));
    _discount =
        TextEditingController(text: widget.discount.first.discount.toString());
    // }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              vietpro = [];
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 25,
            )),
        shadowColor: const Color.fromARGB(255, 203, 203, 203),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          'Edit Promotion',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 181, 57, 5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Divider(
                thickness: 5, color: Color.fromARGB(255, 244, 243, 243)),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text('Start time: '),
                  ),
                ),
              ],
            ),
            const VerticalDivider(),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select start date';
                          }
                          return null;
                        },
                        controller: firstDate,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              firstDate:
                                  DateTime.now().add(const Duration(days: 1)),
                              lastDate: DateTime(2099));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              firstDate.text = formattedDate;
                            });
                          }
                        },
                      ),
                    )),
              ],
            ),
            const Divider(
                thickness: 5, color: Color.fromARGB(255, 244, 243, 243)),
            const Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text('End time: '),
                  ),
                ),
              ],
            ),
            const VerticalDivider(),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select end date';
                          }

                          DateTime startDate = DateTime.parse(firstDate.text);
                          DateTime lastDate = DateTime.parse(value);

                          if (lastDate.isBefore(startDate)) {
                            return 'End date must be after the start date';
                          }
                          return null;
                        },
                        controller: lastDate,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now().add(const Duration(days: 2)),
                              firstDate:
                                  DateTime.now().add(const Duration(days: 2)),
                              lastDate: DateTime(2099));

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              lastDate.text = formattedDate;
                            });
                          }
                        },
                      ),
                    )),
              ],
            ),
            const Divider(thickness: 4, color: Colors.black),
            const Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text('Discount: '),
                )),
              ],
            ),
            const VerticalDivider(),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Discount must be filled with a number lower than price';
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^0+')),
                        ],
                        maxLines: 1,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.attach_money, size: 16)),
                        controller: _discount,
                        keyboardType: TextInputType.number,
                      ),
                    )),
              ],
            ),
            const Divider(thickness: 4, color: Colors.black),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Products',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 197, 32, 20)),
                  )),
                  const VerticalDivider(),
                  Expanded(
                    flex: 0,
                    child: IconButton(
                      icon: const Icon(Icons.add, size: 40),
                      onPressed: () async {
                        await _navigateAndDisplaySelection(
                          context,
                        );
                      },
                    ),
                  ),
                  const VerticalDivider(),
                ],
              ),
            ),
            const Divider(color: Colors.white),
            displayProduct()
          ]),
        ),
      ),
      persistentFooterButtons: [
        Center(
            child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue)),
          onPressed: () {
            double? discountValueInput = double.tryParse(_discount.text);
            if (_formKey.currentState!.validate()) {
              if (widget.discount
                  .any((element) => element.price * 0.1 < discountValueInput!)) {
                final snackBar = SnackBar(
                  content: const Text(
                      'Discount must be equal to 10% of the product price'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (discountValueInput == null) {
                final snackBar = SnackBar(
                  content: const Text(
                      'Discount must be filled with a number lower than price'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                updateAllDiscounts(widget.discount);
                updateDialog(isStatus: widget.discount.first.isStatus);
                vietpro = [];
              }
            }
          },
          child: Text('Save',
              style: GoogleFonts.openSans(color: Colors.white),
              textAlign: TextAlign.center),
        ))
      ],
    );
  }

// List<Discount> currentProducts = [];
  Expanded displayProduct() {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(widget.discount.length, (index) {
              final discount = widget.discount[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    Container(
                      height: 54,
                      width: 57,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          image: NetworkImage(discount.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      discount.title,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '\$${discount.price.toString()}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => New_Prod_Product()));
    print(result);
    if (result != null && result is List) {
      bool isListOfProducts = result.every((element) => element is Product);

      if (isListOfProducts) {
        List<Product> productList = result.cast<Product>();
        updateDisplayedProducts(productList);
      }
    }
  }

  void updateDisplayedProducts(List<Product> newProducts) {
    List<Discount> convertedProducts = newProducts.map((product) {
      return Discount(
        id: product.id,
        discount: 0,
        dateBegin: firstDate.text,
        dateEnd: lastDate.text,
        idProduct: product.id,
        isStatus: 0,
        indC: 0,
        image: product.image,
        price: product.price,
        priceSale: 0,
        timeExpiered: 0,
        title: product.title,
      );
    }).toList();
    tempNewProducts.addAll(newProducts);
    setState(() {
      widget.discount.addAll(convertedProducts);
      displayedProducts = widget.discount.cast<Product>();
      vietpro = tempNewProducts;
      // initializeProductCount();
    });
  }

// void initializeProductCount() {
  //   initialProductCount = displayedProducts.length;
  // }

  List<Product> tempNewProducts = [];

  Future<http.Response> updateSingleDiscount(UpdateData updateData) async {
    var dis = {};
    dis['indC'] = updateData.discount.indC;
    dis['dateBegin'] = firstDate.text;
    dis['dateEnd'] = lastDate.text;
    dis['discount'] = _discount.text;
    dis['isStatus'] = updateData.discount.isStatus;

    final response = await http.post(
      Uri.parse('$u/api/Discount/UpdateDiscount'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(dis),
    );

    if (response.statusCode == 200) {
      print(
          'Update Discount successfully from The Rest API of edit_promotion.dart');
    } else {
      print('Error when updating data in edit_promotion.dart');
    }

    return response;
  }

  Future<void> updateAllDiscounts(List<Discount> discounts) async {
    for (var discount in discounts) {
      await updateSingleDiscount(
          UpdateData(discount: discount, products: tempNewProducts));
      if (tempNewProducts.isNotEmpty) {
        int indC = discounts.first.indC;
        await insertAllDiscount(indC, tempNewProducts);
        tempNewProducts.clear();
      }
    }

    // List<Product> combinedProducts = [...displayedProducts, ...tempNewProducts];
  }

  Future<http.Response> insertSingleDiscount(
      List<Map<String, dynamic>> listOfDiscounts) async {
    final response = await http.post(Uri.parse('$u/api/Discount/insertDis'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(listOfDiscounts));
    return response;
  }

  Future<void> insertAllDiscount(int indC, List<Product> newProducts) async {
    DateTime currentDate = DateTime.now();

    List<Map<String, dynamic>> listOfDiscounts = [];
    // List<Discount> discountList = displayedProducts.cast<Discount>();
    for (var abc in newProducts) {
      print(newProducts.length);
      Map<String, dynamic> dict = {};

      dict['dateBegin'] = firstDate.text;
      dict['dateEnd'] = lastDate.text;
      dict['discount'] = _discount.text;
      dict['idProduct'] = abc.id;
      dict['indC'] = indC;
      DateTime discountStartDate = DateTime.parse(firstDate.text);
      if (currentDate.isBefore(discountStartDate)) {
        dict['isStatus'] = 0;
      } else if (currentDate.isAfter(discountStartDate)) {
        dict['isStatus'] = 1;
      }
      listOfDiscounts.add(dict);
    }

    final response = await insertSingleDiscount(listOfDiscounts);
    if (response.statusCode == 200) {
      print(
          'Add Discount successfully for all products from the REST API of new_promotion.dart');
    } else {
      print('Failed to add Discount.');
      print('Error details: ${response.body}');
    }
  }

  bool isUpdate = false;
  Future<void> updateDialog({required int isStatus}) async {
    if (isUpdate = false ||
        _discount.text.isEmpty ||
        firstDate.text.isEmpty ||
        lastDate.text.isEmpty) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Update promotion',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Failed to update promotion'),
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
                      'Update promotion',
                      style: TextStyle(color: Color.fromARGB(255, 43, 32, 28)),
                    ),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Update promotion successfully!'),
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
                          if (isStatus == 0) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Promotion(ind: 0)));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Promotion(ind: 1)));
                          }

                          setState(() {
                            final snackBar = SnackBar(
                                content:
                                    const Text('Edit promotion successfully!'),
                                action: SnackBarAction(
                                    label: 'Undo', onPressed: () {}));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          });
                        },
                      ),
                    ]);
              });
        });
        setState(() {
          isUpdate = true;
        });
      }
    }
  }
}

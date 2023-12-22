import 'dart:convert';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewPromotion extends StatefulWidget {
  const NewPromotion({super.key});

  @override
  State<NewPromotion> createState() => _NewPromotion();
}

class _NewPromotion extends State<NewPromotion> {
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  List<Product> containSelectedBo = [];
  // Future<Discount>? _futureDiscount;
  final _formKey = GlobalKey<FormState>();
  bool isSelectedProduct = false;
  @override
  void dispose() {
    super.dispose();
    firstDate.dispose();
    lastDate.dispose();
    _discount.dispose();
    containSelectedBo;
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
          'Add new Promotion',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(
                  thickness: 5, color: Color.fromARGB(255, 244, 243, 243)),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('Start time: '),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select start date';
                          }
                          try {
                            DateTime.parse(value);
                          } catch (e) {
                            return 'Invalid date';
                          }
                          return null;
                        },
                        controller: firstDate,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
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
                      )),
                ],
              ),
              const Divider(
                  thickness: 5, color: Color.fromARGB(255, 244, 243, 243)),
              Row(
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Text('End time: '),
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select end date';
                          }
                          try {
                            DateTime.parse(value);
                          } catch (e) {
                            return 'Invalid date';
                          }

                          DateTime startDate = DateTime.parse(firstDate.text);
                          DateTime endDate = DateTime.parse(value);

                          if (endDate.isBefore(startDate) ||
                              endDate.isAtSameMomentAs(startDate)) {
                            return 'End date must be after the start date';
                          }
                          return null;
                        },
                        controller: lastDate,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
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
                      ))
                ],
              ),
              const Divider(thickness: 4, color: Colors.black),
              Row(
                children: [
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text('Discount: '),
                  )),
                  const VerticalDivider(),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter discount';
                          } else if (value.length > 5) {
                            return 'The limitation of discount is 99999';
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.deny(RegExp('^0+'))
                        ],
                        maxLines: 1,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.attach_money, size: 16)),
                        controller: _discount,
                        keyboardType: TextInputType.number,
                      ))
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
                            _navigateAndDisplaySelection(context);
                          },
                        )),
                    const VerticalDivider(),
                  ],
                ),
              ),
              const Divider(color: Colors.white),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(containSelectedBo.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Container(
                          height: 54,
                          width: 57,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      containSelectedBo[index].image),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(containSelectedBo[index].title,
                            // maxLines: 5,
                            // softWrap: true,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('\$${containSelectedBo[index].price.toString()}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  );
                }),
              ))
            ],
          ),
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
              // ignore: unnecessary_null_comparison
              isSelectedProduct =
                  containSelectedBo.any((element) => element != null);
              if (!isSelectedProduct) {
                final snackBar = SnackBar(
                  content: const Text('Please select product'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (containSelectedBo
                  .any((element) => element.price < discountValueInput!)) {
                final snackBar = SnackBar(
                  content: const Text(
                      'Price of product must be higher than discount'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (_navigateAndDisplaySelection(context) == null) {
                final snackBar = SnackBar(
                  content: const Text('No product selected!'),
                  action: SnackBarAction(
                    label: 'Dismiss',
                    onPressed: () {},
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                insertDiscountDialog();
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

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const New_Prod_Product()),
    );
    setState(() {
      containSelectedBo = result;
    });
  }

  Future<http.Response> insertSingleDiscount(List<Map<String, dynamic>> listOfDiscounts) async {
    final response = await http.post(
      Uri.parse('$u/api/Discount/insertDis'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(listOfDiscounts)
    );
    return response;
  }

  Future<void> insertDiscount() async {
    DateTime currentDate = DateTime.now();

    List<Map<String, dynamic>> listOfDiscounts = [];
    for (var idP in containSelectedBo) {
      Map<String, dynamic> dict = {};

      dict['dateBegin'] = firstDate.text;
      dict['dateEnd'] = lastDate.text;
      dict['discount'] = _discount.text;
      dict['idProduct'] = idP.id;

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
      // ignore: avoid_print
      print(
          'Add Discount successfully for all products from the REST API of new_promotion.dart');
    } else {
      // ignore: avoid_print
      print('Failed to add Discount.');
      // ignore: avoid_print
      print('Error details: ${response.body}');
    }
  }

  Future<void> insertDiscountDialog() async {
    {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      Future.delayed(const Duration(seconds: 2), () async {
        await insertDiscount().whenComplete(
          () {
            return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Insert discount ',
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
                            builder: (context) => Promotion(ind: 0)));
                        setState(() {
                          final snackBar = SnackBar(
                              content: const Text('Add discount successfully!'),
                              action: SnackBarAction(
                                  label: 'Undo', onPressed: () {}));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      });
    }
  }
}

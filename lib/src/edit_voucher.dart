import 'dart:convert';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/models/voucher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditVoucher extends StatefulWidget {
  final Voucher voucher;
  const EditVoucher({Key? key, required this.voucher}) : super(key: key);

  @override
  State<EditVoucher> createState() => _EditVoucher();
}

class _EditVoucher extends State<EditVoucher> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _condition = TextEditingController();
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _id.text = widget.voucher.id;
    _discount.text = widget.voucher.discount.toString();
    _condition.text = widget.voucher.condition.toString();
    firstDate.text = widget.voucher.startDate.toString();
    lastDate.text = widget.voucher.endDate.toString();
  }

  final _formKey = GlobalKey<FormState>();
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 203, 203, 203),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'Edit Voucher',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 181, 57, 5),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 2, 0, 0),
                          child: Text('Set voucher',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                      thickness: 5, color: Color.fromARGB(255, 244, 243, 243)),
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
                          child: TextFormField(
                            validator: (value) {
                              final RegExp regExpdOtAndComma = RegExp(r'[.,]');
                              if (value == null || value.isEmpty) {
                                return 'Please enter discount';
                              } else if (value.length > 5) {
                                return 'The limitation of discount is 99999';
                              } else if (regExpdOtAndComma
                                      .allMatches(value)
                                      .length >
                                  1) {
                                return 'Only one . or , is allowed!';
                              } else if (value.startsWith('.') ||
                                  value.startsWith(',') ||
                                  value.startsWith('-') ||
                                  value.startsWith(' ') ||
                                  value.endsWith('.') ||
                                  value.endsWith(',')) {
                                return 'Invalid number';
                              }
                              return null;
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^0+')),
                              // FilteringTextInputFormatter.deny(RegExp(r'-')),
                              // FilteringTextInputFormatter.deny(RegExp(r' ')),
                              // FilteringTextInputFormatter.deny(RegExp(r'^-+')),
                              // FilteringTextInputFormatter.deny(RegExp(r'^,+')),
                              // FilteringTextInputFormatter.deny(RegExp(r'^ +')),
                              // // FilteringTextInputFormatter.deny(
                              // //     RegExp(r'^.+')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\.\.')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\.\,')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\.\-')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\.\ ')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\,\,')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\,\.')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\,\-')),
                              // FilteringTextInputFormatter.deny(RegExp(r'\,\ '))
                            ],
                            maxLines: 1,
                            decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 0),
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.attach_money, size: 16)),
                            controller: _discount,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
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
                        child: Text('Minimum amount: '),
                      )),
                    ],
                  ),
                  const VerticalDivider(),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        validator: (value) {
                          final RegExp regExpdOtAndComma = RegExp(r'[.,]');
                          if (value == null || value.isEmpty) {
                            return 'Please enter condition';
                          } else if (value.length > 5) {
                            return 'The limitation of amount voucher is 99999';
                          } else if (regExpdOtAndComma
                                  .allMatches(value)
                                  .length >
                              1) {
                            return 'Only one . or , is allowed!';
                          } else if (value.startsWith('.') ||
                              value.startsWith(',') ||
                              value.startsWith('-') ||
                              value.startsWith(' ') ||
                              value.endsWith('.') ||
                              value.endsWith(',')) {
                            return 'Invalid number';
                          }

                          int discount = int.parse(_discount.text);
                          int condition = int.parse(_condition.text);
                          if (discount > condition) {
                            return ('Condition should be larger than discount!');
                          } else if (discount == condition) {
                            return ('Invalid condition input');
                          }
                          if (discount >= 0.2 * condition) {
                            return 'Discount is only equal to 80% condition!!';
                          }
                          return null;
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(5),
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^0+')),
                          // FilteringTextInputFormatter.deny(RegExp(r'-')),
                          // FilteringTextInputFormatter.deny(RegExp(r' ')),
                          // FilteringTextInputFormatter.deny(RegExp(r'^-+')),
                          // FilteringTextInputFormatter.deny(RegExp(r'^,+')),
                          // FilteringTextInputFormatter.deny(RegExp(r'^ +')),
                          // // FilteringTextInputFormatter.deny(
                          // //     RegExp(r'^.+')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\.\.')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\.\,')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\.\-')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\.\ ')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\,\,')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\,\.')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\,\-')),
                          // FilteringTextInputFormatter.deny(RegExp(r'\,\ '))
                        ],
                        maxLines: 1,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.attach_money, size: 16)),
                        controller: _condition,
                        keyboardType: TextInputType.number,
                      )),
                    ],
                  ),
                  const Divider(thickness: 5, color: Colors.black),
                  const Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text('Set time',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))))
                    ],
                  ),
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
                                try {
                                  DateTime.parse(value);
                                } catch (e) {
                                  return 'Invalid date';
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
                                    initialDate: DateTime.parse(firstDate.text),
                                    firstDate: DateTime.now()
                                        .add(const Duration(days: 1)),
                                    lastDate: DateTime(2099));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
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
                                try {
                                  DateTime.parse(value);
                                } catch (e) {
                                  return 'Invalid date';
                                }

                                DateTime startDate =
                                    DateTime.parse(firstDate.text);
                                DateTime endDate = DateTime.parse(value);

                                if (endDate.isBefore(startDate)) {
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
                                    initialDate: DateTime.parse(lastDate.text),
                                    firstDate: DateTime.now()
                                        .add(const Duration(days: 2)),
                                    lastDate: DateTime(2099));
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    lastDate.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          )),
                    ],
                  ),
                  const Divider(thickness: 5, color: Colors.black),
                  Row(
                    children: [
                      const Expanded(
                          // key: _formKey,
                          child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                        child: Text('Voucher code: '),
                      )),
                      const VerticalDivider(),
                      Expanded(
                          flex: 1,
                          child: TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 10, 10, 0),
                              ),
                              maxLines: 1,
                              controller: _id))
                    ],
                  ),
                ],
              )),
        ),
      ),
      persistentFooterButtons: [
        Row(children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                updateVoucher();
                updateDialog(widget.voucher.id);
              }
            },
            child: const Text('Update!', textAlign: TextAlign.center),
          )),
        ]),
      ],
    );
  }

// void showLoadingDialog(BuildContext context, VoidCallback onDismissed) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return const Center(child: CircularProgressIndicator());
  //     },
  //   );

  //   Future.delayed(const Duration(seconds: 1), () {
  //     MaterialPageRoute(builder: (context) => Voucher_home(ind: 0));
  //     onDismissed();
  //   });
  // }

  Future<http.Response> updateVoucher() async {
    var id = await getIdSup();
    var vo = {};
    vo['id'] = widget.voucher.id;
    vo['condition'] = int.parse(_condition.text);
    vo['discount'] = int.parse(_discount.text);
    vo['usercreate'] = id;
    vo['startDate'] = firstDate.text;
    vo['endDate'] = lastDate.text;
    vo['isActive'] = widget.voucher.isActive;
    final response = await http.post(Uri.parse('$u/api/Voucher/updateVoucher'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(vo));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print(
          'Update Voucher successfully from The Rest API of edit_voucher.dart');
    } else {
      // ignore: avoid_print
      print('Error when updating data in edit_voucher.dart');
    }
    return response;
  }

  Future<void> updateDialog(String id) async {
    if (isUpdate = false ||
        _discount.text.isEmpty ||
        _condition.text.isEmpty ||
        firstDate.text.isEmpty ||
        lastDate.text.isEmpty) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Update voucher',
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Voucher_home(ind: 0)));
                          setState(() {
                            final snackBar = SnackBar(
                                content:
                                    const Text('Edit voucher successfully!'),
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

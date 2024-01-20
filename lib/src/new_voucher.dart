// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/models/voucher.dart';

class NewVoucher extends StatefulWidget {
  final Voucher? voucher;

  const NewVoucher({
    Key? key,
    this.voucher,
  }) : super(key: key);

  @override
  State<NewVoucher> createState() => _NewVoucher();
}

class _NewVoucher extends State<NewVoucher> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _condition = TextEditingController();
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  Future<Voucher>? _futureVoucher;

  // ignore: non_constant_identifier_names

  @override
  void dispose() {
    _id.dispose();
    _discount.dispose();
    _condition.dispose();
    firstDate.dispose();
    lastDate.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  String isDuplicate = "true";

  checkDuplicateId(String id, String userCreate) async {
    var checkUserV = {};
    checkUserV['userCreate'] = userCreate;
    checkUserV['id'] = id;
    final response = await http.get(
        Uri.parse(
            '$u/api/Voucher/CheckDuplicateIDVoucher?id=$id&userCreate=$userCreate'),
        headers: <String, String>{'Content-Type': 'application/json'});

    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isDuplicate = response.body;
      });
    } else {
      throw Exception('Unable to fetch!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 203, 203, 203),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'Add New Voucher',
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
            child: (_futureVoucher == null)
                ? Column(
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                          thickness: 5,
                          color: Color.fromARGB(255, 244, 243, 243)),
                      const Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text('Discount: '),
                          ))
                        ],
                      ),
                      const VerticalDivider(),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextFormField(
                                validator: (value) {
                                  final RegExp regExpdOtAndComma =
                                      RegExp(r'[.,]');

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
                                  // FilteringTextInputFormatter.allow(
                                  //     RegExp(r'^[1-9]')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^0+')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'-')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r' ')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^-+')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^,+')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'^ +')),
                                  // FilteringTextInputFormatter.deny(
                                  //     RegExp(r'^.+')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\.\.')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\.\,')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\.\-')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\.\ ')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\,\,')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\,\.')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\,\-')),
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\,\ '))
                                ],
                                maxLines: 1,
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    border: OutlineInputBorder(),
                                    suffixIcon:
                                        Icon(Icons.attach_money, size: 16)),
                                controller: _discount,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              )),
                        ],
                      ),
                      const Divider(
                          thickness: 5,
                          color: Color.fromARGB(255, 244, 243, 243)),
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
                                final RegExp regExpdOtAndComma =
                                    RegExp(r'[.,]');
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
                                  return 'Condition should be larger than discount!';
                                } else if (discount == condition) {
                                  return 'Invalid input condition';
                                }
                                if (discount > 0.2 * condition) {
                                  return 'Discount is only equal to 80% condition!!';
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^0+')),
                                FilteringTextInputFormatter.deny(RegExp(r'-')),
                                FilteringTextInputFormatter.deny(RegExp(r' ')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^-+')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^,+')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^ +')),
                                // FilteringTextInputFormatter.deny(
                                //     RegExp(r'^.+')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\.\.')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\.\,')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\.\-')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\.\ ')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\,\,')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\,\.')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\,\-')),
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'\,\ '))
                              ],
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  errorText: null,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                  border: OutlineInputBorder(),
                                  suffixIcon:
                                      Icon(Icons.attach_money, size: 16)),
                              controller: _condition,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                            ),
                          ),
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
                          thickness: 5,
                          color: Color.fromARGB(255, 244, 243, 243)),
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
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 1)),
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
                          thickness: 5,
                          color: Color.fromARGB(255, 244, 243, 243)),
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

                                    if (endDate.isBefore(startDate) ||
                                        endDate.isAtSameMomentAs(startDate)) {
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
                                        initialDate: DateTime.now()
                                            .add(const Duration(days: 2)),
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
                                // onChanged: (value) {
                                //   checkDuplicateId(
                                //       value, widget.voucher!.usercreate);
                                // },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter voucher code';
                                  }

                                  return null;
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9]'))
                                ],
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(10, 10, 10, 0),
                                ),
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                controller: _id),
                          ),
                        ],
                      ),
                    ],
                  )
                : FutureBuilder<Voucher>(
                    future: _futureVoucher,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.toString());
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(children: [
          Expanded(
              child: ElevatedButton(
            onPressed: () {
              //dialog card
              if (_id.text == '') {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        'Failed',
                        style:
                            TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
                      ),
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Please fill full a voucher!'),
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
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 200,
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat('yyyy/MM/dd').format(
                                              DateTime.parse(
                                                  firstDate.text.toString())),
                                          style: GoogleFonts.openSans(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Text(' - '),
                                        Text(
                                          DateFormat('yyyy/MM/dd').format(
                                              DateTime.parse(
                                                  lastDate.text.toString())),
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
                                                    fontWeight: FontWeight.bold,
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
                                              'Discount: ${_discount.text}',
                                              // '',
                                              style: GoogleFonts.openSans(),
                                            ),
                                            Text(
                                              'Condition: ${_condition.text}',
                                              // '',
                                              style: GoogleFonts.openSans(),
                                            ),
                                          ],
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
              }
            },
            child: const Text('Preview', textAlign: TextAlign.center),
          )),
          const VerticalDivider(color: Color.fromARGB(255, 244, 243, 243)),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  // _validateDateRange();
                  if (_formKey.currentState!.validate()) {
                    insertVoucherDialog();
                  }
                },
                child: const Text('Confirm', textAlign: TextAlign.center),
              ))
        ]),
      ],
    );
  }

  void showLoadingDialog(BuildContext context, VoidCallback onDismissed) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      DateTime currentDate = DateTime.now();
      DateTime voucherStartDate = DateTime.parse(firstDate.text);

      if (currentDate.isBefore(voucherStartDate)) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Voucher_home(ind: 0)));
      } else if (currentDate.isAfter(voucherStartDate)) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Voucher_home(ind: 1)));
      }

      onDismissed();
    });
  }

  Future<http.Response> insertVoucher() async {
    var id = await getIdSup();
    var vo = {};
    vo['id'] = _id.text;
    vo['condition'] = int.parse(_condition.text);
    vo['discount'] = int.parse(_discount.text);
    vo['usercreate'] = id;
    vo['startDate'] = firstDate.text;
    vo['endDate'] = lastDate.text;
    vo['used'] = 0;

    DateTime currentDate = DateTime.now();
    DateTime voucherStartDate = DateTime.parse(firstDate.text);
    if (currentDate.isBefore(voucherStartDate)) {
      vo['isActive'] = 0;
    } else if (currentDate.isAfter(voucherStartDate)) {
      vo['isActive'] = 1;
    }
    final response = await http.post(
        Uri.parse('$u/api/Voucher/insertNewVoucher'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(vo));

    if (response.statusCode == 200) {
      // ignore: avoid_print
      print('Add Voucher successfully from The Rest API of new_voucher.dart');
    }
    return response;
  }

  Future<void> insertVoucherDialog() async {
    await checkDuplicateId(_id.text, "ADMIN");
    if (isDuplicate == "true") {
      // ignore: use_build_context_synchronously
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Failed Insert Voucher',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Voucher code is duplicated!'),
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
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      Future.delayed(const Duration(seconds: 2), () async {
        await insertVoucher().whenComplete(
          () {
            return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Insert voucher ',
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
                            builder: (context) => Voucher_home(ind: 0)));
                        setState(() {
                          final snackBar = SnackBar(
                              content: const Text('Add voucher successfully!'),
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

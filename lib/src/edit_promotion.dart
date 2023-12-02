// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:coffee/bundle.dart';
import 'package:coffee/src/models/discount.dart';

// ignore: camel_case_types
class Edit_Promotion extends StatefulWidget {
  final Discount discount;
  const Edit_Promotion({
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
  final TextEditingController _discount = TextEditingController();
  List<Product>? containSelectedBox;

  @override
  void initState() {
    super.initState();
    _discount.text = widget.discount.discount.toString();
    firstDate.text = widget.discount.dateBegin.toString();
    lastDate.text = widget.discount.dateEnd.toString();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
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

                          DateTime startDate = DateTime.parse(firstDate.text);
                          DateTime lastDate = DateTime.parse(value);

                          if (lastDate.isBefore(startDate)) {
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
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
                    child: Text('Giảm giá: '),
                  )),
                  const VerticalDivider(),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
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
                    const Expanded(child: Text('Sản phẩm')),
                    const VerticalDivider(),
                    Expanded(
                        flex: 0,
                        child: IconButton(
                          icon: const Icon(Icons.add, size: 40),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const New_Prod_Product()));
                          },
                        )),
                    const VerticalDivider(),
                  ],
                ),
              ),
              const Divider(color: Colors.white),
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
            if(_formKey.currentState!.validate()){
              
            }
          },
          child: Text('Save',
              style: GoogleFonts.openSans(color: Colors.white),
              textAlign: TextAlign.center),
        ))
      ],
    );
  }
}

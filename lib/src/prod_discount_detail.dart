// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:coffee/bundle.dart';

// ignore: camel_case_types, must_be_immutable
class prod_discount_detail extends StatefulWidget {
  List<Product>? containSelectedBox;
  // ignore: use_super_parameters
  prod_discount_detail({
    Key? key,
    required this.containSelectedBox,
  }) : super(key: key);

  @override
  State<prod_discount_detail> createState() => _prod_discount_detail();
}

@override
// ignore: camel_case_types
class _prod_discount_detail extends State<prod_discount_detail> {
  List<Product>? containSelectedBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        shadowColor: Color.fromARGB(255, 203, 203, 203),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        title: Text(
          'Product detail',
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
              // handle the press
            },
          ),
        ],
      ),
      body: Product_detail(),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: ((context) => New_Prod_Product())));
              },
              child: Text('Add Product',
                  style: GoogleFonts.openSans(color: Colors.black),
                  textAlign: TextAlign.center),
            )),
            const VerticalDivider(
                thickness: 0, color: Color.fromARGB(255, 244, 243, 243)),
            Expanded(
                child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              onPressed: () {
              
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewPromotion(),
                          
                    ));
              },
              child: Text('Confirm',
                  style: GoogleFonts.openSans(color: Colors.white),
                  textAlign: TextAlign.center),
            ))
          ],
        )
      ],
    );
  }

  // getImage() {
  //   return Container(
  //       padding: const EdgeInsets.all(0),
  //       child: Column(
  //         children: [
  //           GridView.builder(
  //               shrinkWrap: true,
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 4),
  //               physics: const NeverScrollableScrollPhysics(),
  //               itemCount: widget.containSelectedBox!.length,
  //               itemBuilder: (context, int index) {
  //                 return Row(children: [
  //                   Column(
  //                     children: [
  //                       SizedBox(
  //                         width: 90,
  //                         height: 90,
  //                         child: Image.network(
  //                             widget.containSelectedBox![index].image),
  //                       ),
  //                     ],
  //                   ),
  //                 ]);
  //               })
  //         ],
  //       ));
  // }

  // ignore: non_constant_identifier_names
  Product_detail() {
    return Container(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.containSelectedBox!.length,
                itemBuilder: (context, int index) {
                  return Row(children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 90,
                          height: 90,
                          child: Image.network(
                              widget.containSelectedBox![index].image),
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                      ],
                    ),
                    const VerticalDivider(width: 10),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              widget.containSelectedBox![index].title.length >
                                      30
                                  ? '${widget.containSelectedBox![index].title.substring(0, 26)}...'
                                  : widget.containSelectedBox![index].title,
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
                              '\$${widget.containSelectedBox![index].price}',
                              style: GoogleFonts.openSans(),
                            ),
                          ],
                        ),
                      ],
                    )
                  ]);
                })
          ],
        ));
  }
}

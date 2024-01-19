


import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/order.dart';
import 'package:coffee/src/orderdetail.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Refund extends StatefulWidget {
 final flagRefund ;
final idinvoice;
final InvoiceSupplier invoice;

  const Refund({Key? key,required this.flagRefund,required this.idinvoice,required this.invoice }) : super(key: key);

  @override
  State<Refund> createState() => _Refund();
}

class _Refund extends State<Refund> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Refund",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
                children: [
                  Text('You must to refund'+widget.flagRefund.toString()+'for ILA'),
                    Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                                style: OutlinedButton
                                                    .styleFrom(
                                                        side: BorderSide(
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    181,
                                                                    57,
                                                                    5))),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                            Orderdetail(invoice: widget.invoice)));
                                                },
                                                child: Text('Cancel',
                                                    style: TextStyle(
                                                        color:
                                                            Color.fromARGB(
                                                                255,
                                                                181,
                                                                57,
                                                                5)))),
                                            ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255,
                                                          250,
                                                          211,
                                                          211), // Background color
                                                ),
                                                
                                                onPressed: () {
                                                 
                                                  supConfirmRefund();
                                                  areyousure();

                                                },
                                                child: Text(
                                                  'Approve',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 181, 57, 5)),
                                                ))
                                          ],
                                        )
                                 
                ],
               )),
        ));
  }
  Future<void> areyousure() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
         return AlertDialog(
            title: const Text(
              'Confirm Order',
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
                      builder: (context) => Order(initialPage: 0)));
                },
              ),
            ],
          );
        });
  }


supConfirmRefund() async {
    var ids = await getIdSup();
    var a = widget.idinvoice;
    final response = await http.get(Uri.parse(
        '$u/api/Invoice/supplierConfirmRefund?idInvoice=$a&idSupplier=$ids'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}


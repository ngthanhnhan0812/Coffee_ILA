import 'dart:convert';
import 'dart:io';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/orderdetail.dart';
import 'package:coffee/src/reviewoforder.dart';
import 'package:http/http.dart' as http;
import 'package:coffee/src/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderWidget1 extends StatefulWidget {
  @override
  State<OrderWidget1> createState() => _OrderWidget1();
}

class _OrderWidget1 extends State<OrderWidget1> {
  late int pros;
  
@override
void initState(){
  fetchInvoiceSupplier(0);
  super.initState();
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<InvoiceSupplier>>(
          future: fetchInvoiceSupplier(0),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int inde) {
                        return Container(
                          height: 274,
                          width: 380,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![inde].nameCus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                        future: fetchOrderDetail(
                                            snapshot.data![inde].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                              color:Color.fromARGB(255, 231, 231, 231),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot.data!.image
                                                                .toString()),
                                                      )),
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 240,
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot
                                                                      .data!
                                                                      .nameProduct!
                                                                      .length >
                                                                  40
                                                              ? snapshot.data!
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  '...'
                                                              : snapshot.data!
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("x" +
                                                        snapshot.data!.amount
                                                            .toString()),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!.price!
                                                             .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(
                                                          Icons.attach_money,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    CupertinoButton(
                                        child: Container(
                                          height: 30,
                                          width: 380,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233)))),
                                          child: Center(
                                            child: Text(
                                              "See more product",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 87, 87, 87),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                     
                                        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Orderdetail(
                                                          invoice: snapshot
                                                              .data![inde])));
                                
                                 
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future:
                                                quati(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data.toString() +
                                                    " Products",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }),
                                        FutureBuilder(
                                            future:
                                                totalOrderAmount(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                            if(snapshot.data != null){
                                               if(snapshot.hasData){
                                              num a = int.parse(snapshot.data!.toString());
                                               return Text(
                                                "Subtotal:" +
                                                    a.toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                             } else if(snapshot.hasError){
                                              return SizedBox();
                                             }
                                            }else{
                                              return SizedBox();
                                            }
                                             return SizedBox();
                                            }),
                                      ],
                                    ),
                                   
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Waiting',
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 8, 131, 197),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 90,
                                          child: CupertinoButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Detail',
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 181, 57, 5),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_right,
                                                    color: Color.fromARGB(
                                                        255, 181, 57, 5),
                                                  )
                                                ],
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Orderdetail(
                                                                invoice: snapshot
                                                                        .data![
                                                                    inde])));
                                              }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 380,
                                color: Color.fromARGB(255, 244, 244, 244),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
  
}

class OrderWidget2 extends StatefulWidget {
  @override
  State<OrderWidget2> createState() => _OrderWidget2();
}

class _OrderWidget2 extends State<OrderWidget2> {
  @override
void initState(){
  fetchInvoiceSupplier(1);
  super.initState();
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<InvoiceSupplier>>(
          future: fetchInvoiceSupplier(1),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int inde) {
                        return Container(
                          height: 244,
                          width: 380,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Column(
                                  children: [
                                  SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![inde].nameCus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                        future: fetchOrderDetailStatus1(
                                            snapshot.data![inde].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                           if(snapshot.data !=null){
                                             return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                              color:Color.fromARGB(255, 231, 231, 231),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot.data!.image
                                                                .toString()),
                                                      )),
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 240,
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot
                                                                      .data!
                                                                      .nameProduct!
                                                                      .length >
                                                                  40
                                                              ? snapshot.data!
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  '...'
                                                              : snapshot.data!
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("x" +
                                                        snapshot.data!.amount
                                                            .toString()),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!.price!
                                                              .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(
                                                          Icons.attach_money,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                        
                                           } else{
                                            return SizedBox();
                                           }
                                          } else if (snapshot.hasError) {
                                            return SizedBox();
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    CupertinoButton(
                                        child: Container(
                                          height: 30,
                                          width: 380,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233)))),
                                          child: Center(
                                            child: Text(
                                              "See more product",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 87, 87, 87),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail1(
                                                          invoice: snapshot
                                                              .data![inde])));
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future:
                                                quatiDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              if(snapshot.data !=null){
                                                  return Text(
                                                snapshot.data.toString() +
                                                    " Products",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else{
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                            return SizedBox();
                                            }),
                                        FutureBuilder(
                                            future:
                                                totalDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                             
                                            if(snapshot.hasData){
                                              if( snapshot.data != null){
                                                 num a = int.parse(snapshot.data!.toString());
                                                  return Text(
                                                "Subtotal:" +
                                                    a.toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else {
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                           return SizedBox();
                                            }),
                                      ],
                                    ),
                                   
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivering',
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 43, 144, 43)
                                                 ,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Order is being processed',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                      255, 69, 68, 68)
                                                  .withOpacity(0.5),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 380,
                                color: Color.fromARGB(255, 239, 239, 239),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class OrderWidget3 extends StatefulWidget {
  @override
  State<OrderWidget3> createState() => _OrderWidget3();
}

class _OrderWidget3 extends State<OrderWidget3> {
  @override
void initState(){
  fetchInvoiceSupplier(3);
  super.initState();
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<InvoiceSupplier>>(
          future: fetchInvoiceSupplier(3),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int inde) {
                        return Container(
                          height: 274,
                          width: 380,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![inde].nameCus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                        future: fetchOrderDetail(
                                            snapshot.data![inde].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                              color:Color.fromARGB(255, 231, 231, 231),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot.data!.image
                                                                .toString()),
                                                      )),
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 240,
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot
                                                                      .data!
                                                                      .nameProduct!
                                                                      .length >
                                                                  40
                                                              ? snapshot.data!
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  '...'
                                                              : snapshot.data!
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("x" +
                                                        snapshot.data!.amount
                                                            .toString()),
                                                     Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!.price!
                                                              .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(
                                                          Icons.attach_money,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    CupertinoButton(
                                        child: Container(
                                          height: 30,
                                          width: 380,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233)))),
                                          child: Center(
                                            child: Text(
                                              "See more product",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 87, 87, 87),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail2(
                                                          invoice: snapshot
                                                              .data![inde])));
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                       FutureBuilder(
                                            future:
                                                quatiDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              if(snapshot.data !=null){
                                                  return Text(
                                                snapshot.data.toString() +
                                                    " Products",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else{
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                            return SizedBox();
                                            }),
                                       FutureBuilder(
                                            future:
                                                totalDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                             
                                            if(snapshot.hasData){
                                              if( snapshot.data != null){
                                                 num a = int.parse(snapshot.data!.toString());
                                                  return Text(
                                                "Subtotal:" +
                                                    a.toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else {
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                           return SizedBox();
                                            }),
                                      ],
                                    ),
                                   
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivered',
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 11, 139, 139)
                                                  ,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 181, 57, 5)),
                                            onPressed: () {areyousure(snapshot.data![inde].id );},
                                            child: Text(
                                              "Received money",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 380,
                                color: Color.fromARGB(255, 239, 239, 239),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
  Future<http.Response> supConfirmReceivedMoney(idInvoice) async {
     var ids =await getIdSup();
    var invde = new Map();
    invde["userCase"] = 1;
    invde["statusType"] = 2;
    invde["idSupplier"] = ids;
    invde["idInvoice"] = idInvoice;
    invde["idInvoiceDetails"] = 0;
    final response =
        await http.post(Uri.parse('$u/api/Invoice/statusOfInvoice'),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            body: jsonEncode(invde));
    print('add product success');
    return response;
  }
  Future<void> areyousure(idInvoice) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Did you receive the money?',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure ?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  confirm(idInvoice);
                },
              ),
            ],
          );
        });
  }

  Future<void> confirm(idInvoice) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    await supConfirmReceivedMoney(idInvoice).whenComplete(
      () {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Received Money',
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
                        builder: (context) => Order(initialPage: 3)));
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

}

class OrderWidget4 extends StatefulWidget {
  @override
  State<OrderWidget4> createState() => _OrderWidget4();
}

class _OrderWidget4 extends State<OrderWidget4> {
  @override
void initState(){
 fetchInvoiceSupplierCanceled() ;
  super.initState();
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<InvoiceSupplier>>(
          future: fetchInvoiceSupplierCanceled(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int inde) {
                        return Container(
                          height: 274,
                          width: 380,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Column(
                                  children: [
                                   SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![inde].nameCus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                        future: fetchOrderDetail(
                                            snapshot.data![inde].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                              color:Color.fromARGB(255, 231, 231, 231),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot.data!.image
                                                                .toString()),
                                                      )),
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 240,
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot
                                                                      .data!
                                                                      .nameProduct!
                                                                      .length >
                                                                  40
                                                              ? snapshot.data!
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  '...'
                                                              : snapshot.data!
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("x" +
                                                        snapshot.data!.amount
                                                            .toString()),
                                                     Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!.price!
                                                              .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(
                                                          Icons.attach_money,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    CupertinoButton(
                                        child: Container(
                                          height: 30,
                                          width: 380,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233)))),
                                          child: Center(
                                            child: Text(
                                              "See more product",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 87, 87, 87),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail4(
                                                          invoice: snapshot
                                                              .data![inde])));
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future:
                                                quati(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data.toString() +
                                                    " Products",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }),
                                       Text(
                                      'Canceled',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                                  255, 69, 68, 68)
                                              .withOpacity(0.5),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                      ],
                                    ),
                                   
                                   
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 380,
                                color: Color.fromARGB(255, 239, 239, 239),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class OrderWidget5 extends StatefulWidget {
  @override
  State<OrderWidget5> createState() => _OrderWidget5();
}

class _OrderWidget5 extends State<OrderWidget5> {
  @override
void initState(){
  fetchInvoiceSupplier(4);
  super.initState();
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<InvoiceSupplier>>(
          future: fetchInvoiceSupplier(4),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int inde) {
                        return Container(
                          height: 274,
                          width: 380,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![inde].nameCus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                        future: fetchOrderDetail(
                                            snapshot.data![inde].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                              color:Color.fromARGB(255, 231, 231, 231),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot.data!.image
                                                                .toString()),
                                                      )),
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 240,
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot
                                                                      .data!
                                                                      .nameProduct!
                                                                      .length >
                                                                  40
                                                              ? snapshot.data!
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  '...'
                                                              : snapshot.data!
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("x" +
                                                        snapshot.data!.amount
                                                            .toString()),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!.price!
                                                              .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(
                                                          Icons.attach_money,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    CupertinoButton(
                                        child: Container(
                                          height: 30,
                                          width: 380,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233)))),
                                          child: Center(
                                            child: Text(
                                              "See more product",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 87, 87, 87),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail5(
                                                          invoice: snapshot
                                                              .data![inde])));
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future:
                                                quatiDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                              return Text(
                                                snapshot.data.toString() +
                                                    " Products",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }),
                                        FutureBuilder(
                                            future:
                                                totalDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                             
                                            if(snapshot.hasData){
                                              if( snapshot.data != null){
                                                 num a = int.parse(snapshot.data!.toString());
                                                  return Text(
                                                "Subtotal:" +
                                                    a.toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else {
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                           return SizedBox();
                                            }),
                                      ],
                                    ),
                                   
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivered',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                      255, 69, 68, 68)
                                                  .withOpacity(0.5),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 181, 57, 5)),
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReviewOfOrder(invoice: snapshot.data![inde])));
                                            },
                                            child: Text(
                                              "Reviews",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.white),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 380,
                                color: Color.fromARGB(255, 239, 239, 239),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

}
class OrderWidget6 extends StatefulWidget {
  @override
  State<OrderWidget6> createState() => _OrderWidget6();
}

class _OrderWidget6 extends State<OrderWidget6> {
  @override
void initState(){
  fetchInvoiceSupplier(2);
  super.initState();
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<InvoiceSupplier>>(
          future: fetchInvoiceSupplier(2),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int inde) {
                        return Container(
                          height: 244,
                          width: 380,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                                child: Column(
                                  children: [
                                  SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data![inde].nameCus
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FutureBuilder(
                                        future: fetchOrderDetailStatus1(
                                            snapshot.data![inde].id),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                           if(snapshot.data !=null){
                                             return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                              color:Color.fromARGB(255, 231, 231, 231),
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot.data!.image
                                                                .toString()),
                                                      )),
                                                  width: 70,
                                                  height: 70,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                      width: 240,
                                                      child: Center(
                                                        child: Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot
                                                                      .data!
                                                                      .nameProduct!
                                                                      .length >
                                                                  40
                                                              ? snapshot.data!
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  '...'
                                                              : snapshot.data!
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                    ),
                                                    Text("x" +
                                                        snapshot.data!.amount
                                                            .toString()),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          snapshot.data!.price!
                                                              .toStringAsFixed(2),
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Icon(
                                                          Icons.attach_money,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            );
                                        
                                           } else{
                                            return SizedBox();
                                           }
                                          } else if (snapshot.hasError) {
                                            return SizedBox();
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                    CupertinoButton(
                                        child: Container(
                                          height: 30,
                                          width: 380,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              233,
                                                              233,
                                                              233)))),
                                          child: Center(
                                            child: Text(
                                              "See more product",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 87, 87, 87),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetail6(
                                                          invoice: snapshot
                                                              .data![inde])));
                                        }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FutureBuilder(
                                            future:
                                                quatiDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              if(snapshot.data !=null){
                                                  return Text(
                                                snapshot.data.toString() +
                                                    " Products",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else{
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                            return SizedBox();
                                            }),
                                        FutureBuilder(
                                            future:
                                                totalDelivery(snapshot.data![inde].id),
                                            builder: (context, snapshot) {
                                             
                                            if(snapshot.hasData){
                                              if( snapshot.data != null){
                                                 num a = int.parse(snapshot.data!.toString());
                                                  return Text(
                                                "Subtotal:" +
                                                    a.toStringAsFixed(2),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 45, 45, 45),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              }else {
                                                return SizedBox();
                                              }
                                            }else if(snapshot.hasError){
                                              return SizedBox();
                                            }
                                           return SizedBox();
                                            }),
                                      ],
                                    ),
                                   
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Delivering',
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 43, 144, 43)
                                                 ,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          'Order is being processed',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                      255, 69, 68, 68)
                                                  .withOpacity(0.5),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 380,
                                color: Color.fromARGB(255, 239, 239, 239),
                              )
                            ],
                          ),
                        );
                      }),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            // By default show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

Future totalDelivery(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    List jsonDelivered=[];
for(int i= 0; i<jsonResponse.length;i++){
  if(jsonResponse[i]["isStatus"] !=2 && jsonResponse[i]["isStatus"] !=3 ){
jsonDelivered.add(jsonResponse[i]);
  }
}
num sum = 0;

    for (int i = 0; i < jsonDelivered.length; i++) {
      if (jsonDelivered[i]["isStatus"]!=2) {
        num e = jsonDelivered[i]["price"];
        sum += e;
      }
    }

    return sum;
   
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<InvoiceSupplier> fetchOrderDetailStatus1(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    List jss=[];
    for(int i=0; i<jsonResponse.length;i++){
      if(jsonResponse[i]["isStatus"] != 2){
        jss.add(jsonResponse[i]);
      }
    }
    var jsonOne = jss[0];
    print(jsonOne);
    return InvoiceSupplier.fromJson(jsonOne);
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<InvoiceSupplier> fetchOrderDetailStatus2(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    List jss=[];
    for(int i=0; i<jsonResponse.length;i++){
      if(jsonResponse[i]["isStatus"] == 2){
        jss.add(jsonResponse[i]);
      }
    }
    var jsonOne = jss[0];
    print(jsonOne);
    return InvoiceSupplier.fromJson(jsonOne);
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<InvoiceSupplier>> fetchInvoiceSupplier(int statu) async {
   var ids =await getIdSup();
  final response = await http
      .get(Uri.parse('$u/api/InvoiceSupplier/GetNameAddDate?idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    List jsonStatus = [];
    for (int i = 0; i < jsonResponse.length; i++) {
      if (jsonResponse[i]['status'] == statu) {
        jsonStatus.add(jsonResponse[i]);
      }
    }

    return jsonStatus.map((data) => InvoiceSupplier.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<InvoiceSupplier>> fetchInvoiceSupplierCanceled() async {
   var ids =await getIdSup();
  final response = await http
      .get(Uri.parse('$u/api/InvoiceSupplier/GetNameAddDate?idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    List jsonStatus = [];
    for (int i = 0; i < jsonResponse.length; i++) {
      if (jsonResponse[i]['status'] == 9 ) {
        jsonStatus.add(jsonResponse[i]);
      }
    }

    return jsonStatus.map((data) => InvoiceSupplier.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<Reviews>> reviewOfOrderSup(idInvoice) async {
   var ids =await getIdSup();
  final response = await http
      .get(Uri.parse('$u/api/Supplier/Review/ReviewOrderSupplier?idSupplier=$ids&idInvoice=$idInvoice'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
   

    return jsonResponse.map((data) => Reviews.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future quati(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    int d = jsonResponse.length;
    return d;
    // return jsonResponse.map((data ) => InvoiceSupplier.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future quatiDelivery(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    List jss=[];
    for(int i = 0; i<jsonResponse.length;i++){
      if(jsonResponse[i]["isStatus"] !=2){
jss.add(jsonResponse[i]);
      }
    }
    int d = jss.length;
    return d;
    // return jsonResponse.map((data ) => InvoiceSupplier.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<InvoiceSupplier>> fetchAllOrderdetail(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);

    return jsonResponse.map((data) => InvoiceSupplier.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future<List<InvoiceSupplier>> fetchAllOrderdetailDelivered(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    return jsonResponse.map((data) => InvoiceSupplier.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<InvoiceSupplier> fetchOrderDetail(idinvoice) async {
   var ids =await getIdSup();
  final response = await http.get(Uri.parse(
      '$u/api/InvoiceSupplier/getDetailOrder?id=$idinvoice&idSupplier=$ids'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    var jsonOne = jsonResponse[0];
    return InvoiceSupplier.fromJson(jsonOne);
  } else {
    throw Exception('Unexpected error occured!');
  }
}
 totalOrderAmount(idinvoice) async {
   var ids =await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalOrderAmount?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
    var a= jsonResponse[0]["totalOrderAmount"];

        
    return a;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
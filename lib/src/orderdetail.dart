import 'dart:convert';

import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/order.dart';
import 'package:coffee/src/orderWidget.dart';
import 'package:coffee/src/refund.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;

class NewInvoice {
  int? idInvoice;
  int? idSupplier;
  bool? flagRefund;
  double? priceRefund;
  bool? flagSuccess;

  NewInvoice(
      {this.idInvoice,
      this.idSupplier,
      this.flagRefund,
      this.priceRefund,
      this.flagSuccess});

  NewInvoice.fromJson(Map<String, dynamic> json) {
    idInvoice = json['idInvoice'];
    idSupplier = json['idSupplier'];
    flagRefund = json['flagRefund'];
    priceRefund = json['priceRefund'];
    flagSuccess = json['flagSuccess'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idInvoice'] = this.idInvoice;
    data['idSupplier'] = this.idSupplier;
    data['flagRefund'] = this.flagRefund;
    data['priceRefund'] = this.priceRefund;
    data['flagSuccess'] = this.flagSuccess;
    return data;
  }
}

class Orderdetail extends StatefulWidget {
  final InvoiceSupplier invoice;

  Orderdetail({Key? key, required this.invoice}) : super(key: key);

  @override
  State<Orderdetail> createState() => _Orderdetail();
}

class _Orderdetail extends State<Orderdetail> {
  List checkListItems = [];
  bool _selected = false;
  bool chk = true;
  bool su = false;
  bool flagRefund = true;
  bool flagSuccess = true;
  num? priceRefund =0;
  @override
  void initState() {
    super.initState();

    waiting();
    getData();
  }

  @override
  Widget build(BuildContext build) {
    
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Order Details",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: su == false
              ? SizedBox()
              : Container(
                  child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 380,
                      color: Color.fromARGB(255, 244, 244, 244),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Address:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                              child: ReadMoreText(
                                widget.invoice.address.toString(),
                                trimLines: 2,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 82, 82, 82)),
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                lessStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Name Customer: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.invoice.nameCus!.length > 20
                                      ? widget.invoice.nameCus!
                                              .substring(0, 20) +
                                          '...'
                                      : widget.invoice.nameCus!.toString(),
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Phone: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.invoice.phone.toString(),
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    chk
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: FutureBuilder(
                                  future:
                                      fetchAllOrderdetail(widget.invoice.id),
                                  builder: (context, snaphot) {
                                    if (snaphot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: snaphot.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              height: 111,
                                              width: 380,
                                              child: Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      231,
                                                                      231,
                                                                      231),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(snaphot
                                                                      .data![
                                                                          index]
                                                                      .image
                                                                      .toString()),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          width: 240,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                snaphot
                                                                            .data![
                                                                                index]
                                                                            .nameProduct!
                                                                            .length >
                                                                        20
                                                                    ? "   " +
                                                                        snaphot
                                                                            .data![
                                                                                index]
                                                                            .nameProduct!
                                                                            .substring(0,
                                                                                20) +
                                                                        '...'
                                                                    : "   " +
                                                                        snaphot
                                                                            .data![index]
                                                                            .nameProduct
                                                                            .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "   Amount : x" +
                                                                        snaphot
                                                                            .data![index]
                                                                            .amount
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .attach_money,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5),
                                                                        ),
                                                                        Text(
                                                                          snaphot
                                                                              .data![index]
                                                                              .price!
                                                                              .toStringAsFixed(2),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 181, 57, 5),
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 18,
                                                                  child: Text(
                                                                    // ignore: prefer_interpolation_to_compose_strings
                                                                    "   Unit price:" +
                                                                        unitprice(snaphot.data![index].price,
                                                                                snaphot.data![index].amount)
                                                                            .toStringAsFixed(2),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12),
                                                                  )),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              (snaphot.data![index]
                                                                          .isStatus !=
                                                                      1 &&snaphot.data![index]
                                                                          .isStatus !=
                                                                      4&&snaphot.data![index]
                                                                          .isStatus !=
                                                                      0)==true
                                                                  ? Text(
                                                                      "   Canceled",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    )
                                                                  : Text(
                                                                      "   Waiting",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width: 380,
                                                    color: const Color.fromARGB(
                                                        255, 237, 237, 237),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    } else if (snaphot.hasError) {
                                      return Text(snaphot.error.toString());
                                    }
                                    return CircularProgressIndicator();
                                  }),
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        activeColor:
                                            Color.fromARGB(255, 181, 57, 5),
                                        value: _selected,
                                        onChanged: (value) {
                                          setState(() {
                                            _selected = value!;
                                            if (_selected) {
                                              for (var element
                                                  in checkListItems) {
                                                element["value"] = true;
                                              }
                                            } else {
                                              for (var element
                                                  in checkListItems) {
                                                element["value"] = false;
                                              }
                                            }
                                            for (var a in checkListItems) {
                                              print(a["value"]);
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        "Select All",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 380,
                                  color:
                                      const Color.fromARGB(255, 237, 237, 237),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: FutureBuilder(
                                        future: fetchAllOrderdetail(
                                            widget.invoice.id),
                                        builder: (context, snaphot) {
                                          if (snaphot.hasData) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: snaphot.data!.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    height: 101,
                                                    width: 380,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Checkbox(
                                                                  activeColor: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5),
                                                                  value: checkListItems[
                                                                          index]
                                                                      ["value"],
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      checkListItems[index]
                                                                              [
                                                                              "value"] =
                                                                          value!;
                                                                      onItemCilcked();
                                                                    });
                                                                  }),
                                                              Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            231,
                                                                            231,
                                                                            231),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(snaphot
                                                                            .data![
                                                                                index]
                                                                            .image
                                                                            .toString()),
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                width: 190,
                                                                height: 80,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        snaphot.data![index].nameProduct!.length > 20
                                                                            ? snaphot.data![index].nameProduct!.substring(0, 20) +
                                                                                '...'
                                                                            : snaphot.data![index].nameProduct
                                                                                .toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    Text(
                                                                        "Unit price: " +
                                                                            unitprice(snaphot.data![index].price, snaphot.data![index].amount).toStringAsFixed(
                                                                                2),
                                                                        style: TextStyle(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                125,
                                                                                125,
                                                                                125),
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Text(
                                                                          "Amount: x" +
                                                                              snaphot.data![index].amount.toString(),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 125, 125, 125),
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.attach_money,
                                                                                size: 15,
                                                                                color: Color.fromARGB(255, 181, 57, 5),
                                                                              ),
                                                                              Text(
                                                                                snaphot.data![index].price!.toStringAsFixed(2),
                                                                                style: TextStyle(color: Color.fromARGB(255, 181, 57, 5), fontWeight: FontWeight.w500),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ]),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          width: 380,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              237, 237, 237),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                          } else if (snaphot.hasError) {
                                            return Text(
                                                snaphot.error.toString());
                                          }
                                          return CircularProgressIndicator();
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    chk
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Subtotal"),
                                        FutureBuilder(
                                            future: totalODConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                 num a = int.parse(
                                                    snapshot.data!.toString());
                                                return Text(
                                                    a.toStringAsFixed(2));
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Voucher Supplier"),
                                        FutureBuilder(
                                            future: fetchVoucherPrice(
                                                widget.invoice.voucherS),
                                            builder: (context, snapshot) {
                                              if (snapshot.data.toString() ==
                                                  "0") {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      a.toStringAsFixed(2));
                                                } else if (snapshot.hasError) {
                                                  return SizedBox();
                                                }
                                              } else {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      "- ${a.toStringAsFixed(2)}");
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Commission For Admin(10%)"),
                                        FutureBuilder(
                                            future: discountForILAConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == "0.00") {
                                                  return Text(snapshot.data!
                                                      .toString());
                                                } else {
                                                  return Text('-' +
                                                      snapshot.data!
                                                          .toString());
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total (",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.attach_money,
                                                size: 15,
                                              ),
                                              Text(
                                                ") :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: totalOfSupplierConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                return Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Subtotal"),
                                        FutureBuilder(
                                            future: totalOrderAmount(
                                                widget.invoice.id),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                num a = int.parse(
                                                    snapshot.data!.toString());
                                                return Text(
                                                    a.toStringAsFixed(2));
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Voucher Supplier"),
                                        FutureBuilder(
                                            future: fetchVoucherPrice(
                                                widget.invoice.voucherS),
                                            builder: (context, snapshot) {
                                              if (snapshot.data.toString() ==
                                                  "0") {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      a.toStringAsFixed(2));
                                                } else if (snapshot.hasError) {
                                                  return SizedBox();
                                                }
                                              } else {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      "- ${a.toStringAsFixed(2)}");
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Commission For Admin(10%)"),
                                        Text(discountForILA() == 0
                                            ? discountForILA()
                                                .toStringAsFixed(2)
                                            // ignore: prefer_interpolation_to_compose_strings
                                            : "- " +
                                                discountForILA()
                                                    .toStringAsFixed(2))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total (",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.attach_money,
                                                size: 15,
                                              ),
                                              Text(
                                                ") :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: totalOfSupplier(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                return Text(
                                                  snapshot.data
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    chk
                        ? SizedBox()
                        : Container(
                            height: 1,
                            width: 380,
                            color: const Color.fromARGB(255, 243, 243, 243),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Create Date: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.invoice.createDate.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    su == false
                        ? SizedBox()
                        : chk
                            ? Container(
                                height: 50,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 233, 233, 233)),
                                child: Center(
                                  child: Text(
                                    "This Order Had Been Confirm",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 79, 79, 79)),
                                  ),
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                  width: 300, // <-- match_parent

                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 181, 57, 5),
                                    ),
                                    onPressed: () {
                                      areyousure();
                                    },
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                  ],
                )),
        ));
  }
Future<bool> _onWillPop() async {
   return   false;
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
                  Text('Are you sure ?'),
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
              TextButton(
                child: const Text(
                  'Approve',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  confirm();
                },
              ),
            ],
          );
        });
  }

  Future<void> confirm() async {
    await supConfirmInvDe();

    if (flagRefund == false && flagSuccess == true) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
           return WillPopScope(
      onWillPop: () async {
        return _onWillPop();
      },
          child: AlertDialog(
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
          ));
        },
      );
    } else {
      if (flagRefund == true && flagSuccess == true) {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Refund(flagRefund:priceRefund ,idinvoice: widget.invoice.id,invoice: widget.invoice,)));
        }
    }
  }

  onItemCilcked() {
    setState(() {
      int all = 0;
      for (int i = 0; i < checkListItems.length; i++) {
        if (checkListItems[i]["value"] == true) {
          all++;
        }
      }
      if (checkListItems.length == all) {
        _selected = true;
      } else {
        _selected = false;
      }
    });
  }

  getData() async {
    List<InvoiceSupplier> inv = await fetchAllOrderdetail(widget.invoice.id);

    for (int i = 0; i < inv.length; i++) {
      var abc = new Map();
      abc["idinvoicedetail"] = inv[i].idInvoiceDetail;
      abc["price"] = inv[i].price;
      abc["value"] = false;
      checkListItems.add(abc);
    }

    print(checkListItems);
  }

  waiting() async {
    List<InvoiceSupplier> inv = await fetchAllOrderdetail(widget.invoice.id);
    if (inv[0].isStatus != 0) {
      setState(() {
        chk = true;
      });
    } else {
      setState(() {
        chk = false;
      });
    }
    setState(() {
      su = true;
    });
  }

  totalAmountOfProduct() {
    num sum = 0;

    for (int i = 0; i < checkListItems.length; i++) {
      if (checkListItems[i]["value"] == true) {
        num e = checkListItems[i]["price"];
        sum += e;
      }
    }

    return sum;
  }

  totalODConfirmed() async {
    num sum = 0;
    List<InvoiceSupplier> inv = await fetchAllOrderdetail(widget.invoice.id);
    for (int i = 0; i < inv.length; i++) {
      if (inv[i].isStatus != 2 &&inv[i].isStatus != 0&&inv[i].isStatus != 3) {
        num e = inv[i].price!;
        sum += e;
      }
    }

    return sum;
  }

 discountForILAConfirmed() async {
    num dis = await totalODConfirmed() * 1 / 10;

    return dis.toStringAsFixed(2);
  }

  discountForILA() {
    num dis = totalAmountOfProduct() * 1 / 10;
    return dis;
  }

  Future totalOfSupplierConfirmed() async {
    num prvch ;
    final b = await fetchVoucherPrice(widget.invoice.voucherS);
    if(b == "0"){
      prvch = 0;
    }else{
      prvch = num.parse(b.toString());
    }
    final d = await discountForILAConfirmed();
    final e = await totalODConfirmed();
    num c = num.parse(e.toString()) -num.parse(d.toString()) - prvch ;
    num up;
    if (c >= 0) {
      up = c;
    } else {
      up = 0;
    }
    return up.toStringAsFixed(2);
  }

  Future totalOfSupplier() async {
    final b = await fetchVoucherPrice(widget.invoice.voucherS);
    num c = totalAmountOfProduct() - discountForILA() - num.parse(b.toString());
    num sup;
    if (c >= 0) {
      sup = c;
    } else {
      sup = 0;
    }
    return sup.toStringAsFixed(2);
  }

  Future<String> fetchVoucherPrice(lsvoucher) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Voucher/getPriceVoucherInSupplierInvoice?idSupplier=$ids&lsVoucherS=$lsvoucher '));

    if (response.statusCode == 200) {
      print("vouchersup   " + response.body);
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  supConfirmInvDe() async {
    var a = widget.invoice.id;
    List idInvoiceD = [];
    List valueInvoiceD = [];
    for (int i = 0; i < checkListItems.length; i++) {
      idInvoiceD.add(checkListItems[i]['idinvoicedetail']);
      valueInvoiceD.add(checkListItems[i]["value"]);
    }
    String idinvoiced = idInvoiceD
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');
    String valueinvoiced = valueInvoiceD
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '')
        .replaceAll('false', '1')
        .replaceAll('true', '0');
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Invoice/supplierPrepareInvoice?idSupplier=$ids&idInvoice=$a&strLsInvoiceD=$idinvoiced&strLsStatus=$valueinvoiced'));
    if (response.statusCode == 200) {
      var a = NewInvoice.fromJson(jsonDecode(response.body));
      flagRefund = a.flagRefund!;
      flagSuccess = a.flagSuccess!;
      if(a.priceRefund !=null){
priceRefund = a.priceRefund!;
      }
      
      return NewInvoice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  
}

class OrderDetail1 extends StatefulWidget {
  final InvoiceSupplier invoice;

  OrderDetail1({Key? key, required this.invoice}) : super(key: key);

  @override
  State<OrderDetail1> createState() => _OrderDetail1();
}

class _OrderDetail1 extends State<OrderDetail1> {
  bool su = false;
 
  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Order Delivering",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: su == false
              ? SizedBox()
              : Container(
                  child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 380,
                      color: Color.fromARGB(255, 244, 244, 244),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.place),
                                Text(
                                  "Address:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                              child: ReadMoreText(
                                widget.invoice.address.toString(),
                                trimLines: 2,
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 82, 82, 82)),
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                                lessStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.person),
                                Text(
                                  "Name Customer: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  widget.invoice.nameCus!.length > 20
                                      ? widget.invoice.nameCus!
                                              .substring(0, 20) +
                                          '...'
                                      : widget.invoice.nameCus!.toString(),
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                Text(
                                  "Phone: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.invoice.phone.toString(),
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: FutureBuilder(
                                  future: fetchAllOrderdetailDelivered(
                                      widget.invoice.id),
                                  builder: (context, snaphot) {
                                    if (snaphot.hasData) {
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: snaphot.data!.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              height: 111,
                                              width: 380,
                                              child: Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Color.fromARGB(
                                                                      255,
                                                                      231,
                                                                      231,
                                                                      231),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(snaphot
                                                                      .data![
                                                                          index]
                                                                      .image
                                                                      .toString()),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Container(
                                                          width: 240,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                snaphot
                                                                            .data![
                                                                                index]
                                                                            .nameProduct!
                                                                            .length >
                                                                        20
                                                                    ? snaphot
                                                                            .data![
                                                                                index]
                                                                            .nameProduct!
                                                                            .substring(0,
                                                                                20) +
                                                                        '...'
                                                                    : snaphot
                                                                        .data![
                                                                            index]
                                                                        .nameProduct
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Amount: x" +
                                                                        snaphot
                                                                            .data![index]
                                                                            .amount
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .attach_money,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5),
                                                                        ),
                                                                        Text(
                                                                          snaphot
                                                                              .data![index]
                                                                              .price!
                                                                              .toStringAsFixed(2),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 181, 57, 5),
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 18,
                                                                child: Text(
                                                                    "Unit price: " +
                                                                        unitprice(snaphot.data![index].price, snaphot.data![index].amount)
                                                                            .toStringAsFixed(2),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              ( snaphot.data![index]
                                                                    .isStatus !=
                                                                3 &&snaphot.data![index]
                                                                    .isStatus !=
                                                                2)==false
                                                                  ? Text(
                                                                      "Canceled",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    )
                                                                  : Text(
                                                                      "Delivering",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.green),
                                                                    ),
                                                            ],
                                                          ),
                                                        )
                                                      ]),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    width: 380,
                                                    color: const Color.fromARGB(
                                                        255, 237, 237, 237),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    } else if (snaphot.hasError) {
                                      return Text(snaphot.error.toString());
                                    }
                                    return CircularProgressIndicator();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                   Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Subtotal"),
                                        FutureBuilder(
                                            future: totalODConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                 num a = int.parse(
                                                    snapshot.data!.toString());
                                                return Text(
                                                    a.toStringAsFixed(2));
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Voucher Supplier"),
                                        FutureBuilder(
                                            future: fetchVoucherPrice(
                                                widget.invoice.voucherS),
                                            builder: (context, snapshot) {
                                              if (snapshot.data.toString() ==
                                                  "0") {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      a.toStringAsFixed(2));
                                                } else if (snapshot.hasError) {
                                                  return SizedBox();
                                                }
                                              } else {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      "- ${a.toStringAsFixed(2)}");
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Commission For Admin(10%)"),
                                        FutureBuilder(
                                            future: discountForILAConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == "0.00") {
                                                  return Text(snapshot.data!
                                                      .toString());
                                                } else {
                                                  return Text('-' +
                                                      snapshot.data!
                                                          .toString());
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total (",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.attach_money,
                                                size: 15,
                                              ),
                                              Text(
                                                ") :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: totalOfSupplierConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                return Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                       Container(
                      height: 1,
                      width: 380,
                      color: const Color.fromARGB(255, 243, 243, 243),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Create Date: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.invoice.createDate.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
        ));
  }
 
totalODConfirmed() async {
    num sum = 0;
    List<InvoiceSupplier> inv = await fetchAllOrderdetailDelivered(widget.invoice.id);
    for (int i = 0; i < inv.length; i++) {
      if (inv[i].isStatus != 3 && inv[i].isStatus !=2) {
       num e = inv[i].price!;
        sum += e;
      }else{
 continue;
      }
    }

    return sum;
  }

 discountForILAConfirmed() async {
    num dis = await totalODConfirmed() * 1 / 10;

    return dis.toStringAsFixed(2);
  }

  

  Future totalOfSupplierConfirmed() async {
    num prvch ;
    final b = await fetchVoucherPrice(widget.invoice.voucherS);
    if(b == "0"){
      prvch = 0;
    }else{
      prvch = num.parse(b.toString());
    }
    final d = await discountForILAConfirmed();
    final e = await totalODConfirmed();
    num c = num.parse(e.toString()) -num.parse(d.toString()) - prvch ;
    num up;
    if (c >= 0) {
      up = c;
    } else {
      up = 0;
    }
    return up.toStringAsFixed(2);
  }

 

  Future<String> fetchVoucherPrice(lsvoucher) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Voucher/getPriceVoucherInSupplierInvoice?idSupplier=$ids&lsVoucherS=$lsvoucher '));

    if (response.statusCode == 200) {
      print("vouchersup   " + response.body);
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  totalAmountOfProduct(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalAmountOfProduct?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalAmountOfProduct"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  totalOrderAmount(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalOrderAmount?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      await jsonResponse[0]["totalOrderAmount"];
      return jsonResponse[0]["totalOrderAmount"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  loading() {
    if (totalAmountOfProduct(widget.invoice.id) != null) {
      setState(() {
        su = true;
      });
    }
  }

  refundtoCustomer(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetRefundtoCustomers?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["refundtoCustomers"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

class OrderDetail2 extends StatefulWidget {
  final InvoiceSupplier invoice;

  OrderDetail2({Key? key, required this.invoice}) : super(key: key);

  @override
  State<OrderDetail2> createState() => _OrderDetail2();
}

class _OrderDetail2 extends State<OrderDetail2> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Delivered",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 150,
                width: 380,
                color: Color.fromARGB(255, 244, 244, 244),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.place),
                          Text(
                            "Address:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                        child: ReadMoreText(
                          widget.invoice.address.toString(),
                          trimLines: 2,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 82, 82, 82)),
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            "Name Customer: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.invoice.nameCus!.length > 20
                                ? widget.invoice.nameCus!.substring(0, 20) +
                                    '...'
                                : widget.invoice.nameCus!.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Text(
                            "Phone: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.invoice.phone.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FutureBuilder(
                            future:
                                fetchAllOrderdetailDelivered(widget.invoice.id),
                            builder: (context, snaphot) {
                              if (snaphot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snaphot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 111,
                                        width: 380,
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 231, 231, 231),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snaphot
                                                                    .data![
                                                                        index]
                                                                    .image
                                                                    .toString()),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 240,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .length >
                                                                  20
                                                              ? snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snaphot
                                                                  .data![index]
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Amount: x" +
                                                                  snaphot
                                                                      .data![
                                                                          index]
                                                                      .amount
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          125,
                                                                          125,
                                                                          125),
                                                                  fontSize: 12),
                                                            ),
                                                            Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .attach_money,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5),
                                                                        ),
                                                                        Text(
                                                                          snaphot
                                                                              .data![index]
                                                                              .price!
                                                                              .toStringAsFixed(2),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 181, 57, 5),
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                         SizedBox(
                                                                height: 18,
                                                                child: Text(
                                                                    "Unit price: " +
                                                                        unitprice(snaphot.data![index].price, snaphot.data![index].amount)
                                                                            .toStringAsFixed(2),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                       ( snaphot.data![index]
                                                                    .isStatus !=
                                                                3 &&snaphot.data![index]
                                                                    .isStatus !=
                                                                2)==false
                                                            ? Text(
                                                                "Canceled",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              )
                                                            : Text(
                                                                "Delivered",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            11,
                                                                            139,
                                                                            139)),
                                                              ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 380,
                                              color: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snaphot.hasError) {
                                return Text(snaphot.error.toString());
                              }
                              return CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Subtotal"),
                                        FutureBuilder(
                                            future: totalODConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                 num a = int.parse(
                                                    snapshot.data!.toString());
                                                return Text(
                                                    a.toStringAsFixed(2));
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Voucher Supplier"),
                                        FutureBuilder(
                                            future: fetchVoucherPrice(
                                                widget.invoice.voucherS),
                                            builder: (context, snapshot) {
                                              if (snapshot.data.toString() ==
                                                  "0") {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      a.toStringAsFixed(2));
                                                } else if (snapshot.hasError) {
                                                  return SizedBox();
                                                }
                                              } else {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      "- ${a.toStringAsFixed(2)}");
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Commission For Admin(10%)"),
                                        FutureBuilder(
                                            future: discountForILAConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == "0.00") {
                                                  return Text(snapshot.data!
                                                      .toString());
                                                } else {
                                                  return Text('-' +
                                                      snapshot.data!
                                                          .toString());
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total (",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.attach_money,
                                                size: 15,
                                              ),
                                              Text(
                                                ") :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: totalOfSupplierConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                return Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                         Container(
                height: 1,
                width: 380,
                color: const Color.fromARGB(255, 243, 243, 243),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.invoice.createDate.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }

  totalAmountOfProduct(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalAmountOfProduct?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalAmountOfProduct"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  totalOrderAmount(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalOrderAmount?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalOrderAmount"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
totalODConfirmed() async {
    num sum = 0;
    List<InvoiceSupplier> inv = await fetchAllOrderdetail(widget.invoice.id);
    for (int i = 0; i < inv.length; i++) {
      if (inv[i].isStatus != 3 && inv[i].isStatus !=2) {
        num e = inv[i].price!;
        sum += e;
      }
    }

    return sum;
  }

 discountForILAConfirmed() async {
    num dis = await totalODConfirmed() * 1 / 10;

    return dis.toStringAsFixed(2);
  }

  

  Future totalOfSupplierConfirmed() async {
    num prvch ;
    final b = await fetchVoucherPrice(widget.invoice.voucherS);
    if(b == "0"){
      prvch = 0;
    }else{
      prvch = num.parse(b.toString());
    }
    final d = await discountForILAConfirmed();
    final e = await totalODConfirmed();
    num c = num.parse(e.toString()) -num.parse(d.toString()) - prvch ;
    num up;
    if (c >= 0) {
      up = c;
    } else {
      up = 0;
    }
    return up.toStringAsFixed(2);
  }

 

  Future<String> fetchVoucherPrice(lsvoucher) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Voucher/getPriceVoucherInSupplierInvoice?idSupplier=$ids&lsVoucherS=$lsvoucher '));

    if (response.statusCode == 200) {
      print("vouchersup   " + response.body);
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  refundtoCustomer(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetRefundtoCustomers?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["refundtoCustomers"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

class OrderDetail4 extends StatefulWidget {
  final InvoiceSupplier invoice;

  OrderDetail4({Key? key, required this.invoice}) : super(key: key);

  @override
  State<OrderDetail4> createState() => _OrderDetail4();
}

class _OrderDetail4 extends State<OrderDetail4> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Canceled",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 150,
                width: 380,
                color: Color.fromARGB(255, 244, 244, 244),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.place),
                          Text(
                            "Address:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                        child: ReadMoreText(
                          widget.invoice.address.toString(),
                          trimLines: 2,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 82, 82, 82)),
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            "Name Customer: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.invoice.nameCus!.length > 20
                                ? widget.invoice.nameCus!.substring(0, 20) +
                                    '...'
                                : widget.invoice.nameCus!.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Text(
                            "Phone: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.invoice.phone.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FutureBuilder(
                            future:
                                fetchAllOrderdetailDelivered(widget.invoice.id),
                            builder: (context, snaphot) {
                              if (snaphot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snaphot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 111,
                                        width: 380,
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 231, 231, 231),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snaphot
                                                                    .data![
                                                                        index]
                                                                    .image
                                                                    .toString()),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 240,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .length >
                                                                  20
                                                              ? snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snaphot
                                                                  .data![index]
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Amount: x" +
                                                                  snaphot
                                                                      .data![
                                                                          index]
                                                                      .amount
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          125,
                                                                          125,
                                                                          125),
                                                                  fontSize: 12),
                                                            ),
                                                            Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .attach_money,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5),
                                                                        ),
                                                                        Text(
                                                                          snaphot
                                                                              .data![index]
                                                                              .price!
                                                                              .toStringAsFixed(2),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 181, 57, 5),
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                                height: 18,
                                                                child: Text(
                                                                    "Unit price: " +
                                                                        unitprice(snaphot.data![index].price, snaphot.data![index].amount)
                                                                            .toStringAsFixed(2),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "Canceled",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 380,
                                              color: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snaphot.hasError) {
                                return Text(snaphot.error.toString());
                              }
                              return CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.invoice.createDate.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }

  totalAmountOfProduct(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalAmountOfProduct?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalAmountOfProduct"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  totalOrderAmount(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalOrderAmount?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalOrderAmount"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  refundtoCustomer(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetRefundtoCustomers?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["refundtoCustomers"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

class OrderDetail5 extends StatefulWidget {
  final InvoiceSupplier invoice;

  OrderDetail5({Key? key, required this.invoice}) : super(key: key);

  @override
  State<OrderDetail5> createState() => _OrderDetail5();
}

class _OrderDetail5 extends State<OrderDetail5> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Delivered",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 150,
                width: 380,
                color: Color.fromARGB(255, 244, 244, 244),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.place),
                          Text(
                            "Address:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                        child: ReadMoreText(
                          widget.invoice.address.toString(),
                          trimLines: 2,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 82, 82, 82)),
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            "Name Customer: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.invoice.nameCus!.length > 20
                                ? widget.invoice.nameCus!.substring(0, 20) +
                                    '...'
                                : widget.invoice.nameCus!.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Text(
                            "Phone: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.invoice.phone.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FutureBuilder(
                            future:
                                fetchAllOrderdetailDelivered(widget.invoice.id),
                            builder: (context, snaphot) {
                              if (snaphot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snaphot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 111,
                                        width: 380,
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 231, 231, 231),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snaphot
                                                                    .data![
                                                                        index]
                                                                    .image
                                                                    .toString()),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 240,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .length >
                                                                  20
                                                              ? snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snaphot
                                                                  .data![index]
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Amount: x" +
                                                                  snaphot
                                                                      .data![
                                                                          index]
                                                                      .amount
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          125,
                                                                          125,
                                                                          125),
                                                                  fontSize: 12),
                                                            ),
                                                            Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .attach_money,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5),
                                                                        ),
                                                                        Text(
                                                                          snaphot
                                                                              .data![index]
                                                                              .price!
                                                                              .toStringAsFixed(2),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 181, 57, 5),
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                       SizedBox(
                                                                height: 18,
                                                                child: Text(
                                                                    "Unit price: " +
                                                                        unitprice(snaphot.data![index].price, snaphot.data![index].amount)
                                                                            .toStringAsFixed(2),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        (snaphot.data![index]
                                                                    .isStatus !=
                                                                2&& snaphot.data![index]
                                                                    .isStatus !=
                                                                3)==false
                                                            ? Text(
                                                                "Canceled",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              )
                                                            : Text(
                                                                "Delivered",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            11,
                                                                            139,
                                                                            139)),
                                                              ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 380,
                                              color: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snaphot.hasError) {
                                return Text(snaphot.error.toString());
                              }
                              return CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Subtotal"),
                                        FutureBuilder(
                                            future: totalODConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                 num a = int.parse(
                                                    snapshot.data!.toString());
                                                return Text(
                                                    a.toStringAsFixed(2));
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Voucher Supplier"),
                                        FutureBuilder(
                                            future: fetchVoucherPrice(
                                                widget.invoice.voucherS),
                                            builder: (context, snapshot) {
                                              if (snapshot.data.toString() ==
                                                  "0") {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      a.toStringAsFixed(2));
                                                } else if (snapshot.hasError) {
                                                  return SizedBox();
                                                }
                                              } else {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      "- ${a.toStringAsFixed(2)}");
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Commission For Admin(10%)"),
                                        FutureBuilder(
                                            future: discountForILAConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == "0.00") {
                                                  return Text(snapshot.data!
                                                      .toString());
                                                } else {
                                                  return Text('-' +
                                                      snapshot.data!
                                                          .toString());
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total (",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.attach_money,
                                                size: 15,
                                              ),
                                              Text(
                                                ") :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: totalOfSupplierConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                return Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
          
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.invoice.createDate.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
totalODConfirmed() async {
    num sum = 0;
    List<InvoiceSupplier> inv = await fetchAllOrderdetail(widget.invoice.id);
    for (int i = 0; i < inv.length; i++) {
      if (inv[i].isStatus != 0 && inv[i].isStatus != 2&&inv[i].isStatus !=3) {
        num e = inv[i].price!;
        sum += e;
      }
      else{
        continue;
      }
    }

    return sum;
  }

 discountForILAConfirmed() async {
    num dis = await totalODConfirmed() * 1 / 10;

    return dis.toStringAsFixed(2);
  }

  

  Future totalOfSupplierConfirmed() async {
    num prvch ;
    final b = await fetchVoucherPrice(widget.invoice.voucherS);
    if(b == "0"){
      prvch = 0;
    }else{
      prvch = num.parse(b.toString());
    }
    final d = await discountForILAConfirmed();
    final e = await totalODConfirmed();
    num c = num.parse(e.toString()) -num.parse(d.toString()) - prvch ;
    num up;
    if (c >= 0) {
      up = c;
    } else {
      up = 0;
    }
    return up.toStringAsFixed(2);
  }

 

  Future<String> fetchVoucherPrice(lsvoucher) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Voucher/getPriceVoucherInSupplierInvoice?idSupplier=$ids&lsVoucherS=$lsvoucher '));

    if (response.statusCode == 200) {
      print("vouchersup   " + response.body);
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }


  totalAmountOfProduct(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalAmountOfProduct?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalAmountOfProduct"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  totalOrderAmount(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalOrderAmount?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalOrderAmount"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  refundtoCustomer(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetRefundtoCustomers?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["refundtoCustomers"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
class OrderDetail6 extends StatefulWidget {
  final InvoiceSupplier invoice;

  OrderDetail6({Key? key, required this.invoice}) : super(key: key);

  @override
  State<OrderDetail6> createState() => _OrderDetail6();
}

class _OrderDetail6 extends State<OrderDetail6> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Cus Has Received",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 150,
                width: 380,
                color: Color.fromARGB(255, 244, 244, 244),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.place),
                          Text(
                            "Address:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                        child: ReadMoreText(
                          widget.invoice.address.toString(),
                          trimLines: 2,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 82, 82, 82)),
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            "Name Customer: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.invoice.nameCus!.length > 20
                                ? widget.invoice.nameCus!.substring(0, 20) +
                                    '...'
                                : widget.invoice.nameCus!.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          Text(
                            "Phone: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.invoice.phone.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: FutureBuilder(
                            future:
                                fetchAllOrderdetailDelivered(widget.invoice.id),
                            builder: (context, snaphot) {
                              if (snaphot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snaphot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 111,
                                        width: 380,
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Color.fromARGB(
                                                            255, 231, 231, 231),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snaphot
                                                                    .data![
                                                                        index]
                                                                    .image
                                                                    .toString()),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    width: 240,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .length >
                                                                  20
                                                              ? snaphot
                                                                      .data![
                                                                          index]
                                                                      .nameProduct!
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snaphot
                                                                  .data![index]
                                                                  .nameProduct
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Amount: x" +
                                                                  snaphot
                                                                      .data![
                                                                          index]
                                                                      .amount
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          125,
                                                                          125,
                                                                          125),
                                                                  fontSize: 12),
                                                            ),
                                                            Container(
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .attach_money,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5),
                                                                        ),
                                                                        Text(
                                                                          snaphot
                                                                              .data![index]
                                                                              .price!
                                                                              .toStringAsFixed(2),
                                                                          style: TextStyle(
                                                                              color: Color.fromARGB(255, 181, 57, 5),
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                          ],
                                                        ),
                                                         SizedBox(
                                                                height: 18,
                                                                child: Text(
                                                                    "Unit price: " +
                                                                        unitprice(snaphot.data![index].price, snaphot.data![index].amount)
                                                                            .toStringAsFixed(2),
                                                                    style: TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            125,
                                                                            125,
                                                                            125),
                                                                        fontSize:
                                                                            12)),
                                                              ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                       ( snaphot.data![index]
                                                                    .isStatus !=
                                                                3&&snaphot.data![index]
                                                                    .isStatus !=
                                                                2 )==false
                                                            ? Text(
                                                                "Canceled",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red),
                                                              )
                                                            : Text(
                                                                "Delivered",
                                                                style: TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            11,
                                                                            139,
                                                                            139)),
                                                              ),
                                                      ],
                                                    ),
                                                  )
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 1,
                                              width: 380,
                                              color: const Color.fromARGB(
                                                  255, 237, 237, 237),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              } else if (snaphot.hasError) {
                                return Text(snaphot.error.toString());
                              }
                              return CircularProgressIndicator();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Subtotal"),
                                        FutureBuilder(
                                            future: totalODConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                 num a = int.parse(
                                                    snapshot.data!.toString());
                                                return Text(
                                                    a.toStringAsFixed(2));
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Voucher Supplier"),
                                        FutureBuilder(
                                            future: fetchVoucherPrice(
                                                widget.invoice.voucherS),
                                            builder: (context, snapshot) {
                                              if (snapshot.data.toString() ==
                                                  "0") {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      a.toStringAsFixed(2));
                                                } else if (snapshot.hasError) {
                                                  return SizedBox();
                                                }
                                              } else {
                                                if (snapshot.data != null) {
                                                  num a = int.parse(snapshot
                                                      .data!
                                                      .toString());
                                                  return Text(
                                                      "- ${a.toStringAsFixed(2)}");
                                                } else {
                                                  return SizedBox();
                                                }
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Commission For Admin(10%)"),
                                        FutureBuilder(
                                            future: discountForILAConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                if (snapshot.data == "0.00") {
                                                  return Text(snapshot.data!
                                                      .toString());
                                                } else {
                                                  return Text('-' +
                                                      snapshot.data!
                                                          .toString());
                                                }
                                              } else {
                                                return SizedBox();
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Total (",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.attach_money,
                                                size: 15,
                                              ),
                                              Text(
                                                ") :",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: totalOfSupplierConfirmed(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                return Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                );
                                              } else if (snapshot.hasError) {
                                                return SizedBox();
                                              }
                                              return SizedBox();
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                         Container(
                height: 1,
                width: 380,
                color: const Color.fromARGB(255, 243, 243, 243),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.invoice.createDate.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }

  totalAmountOfProduct(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalAmountOfProduct?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalAmountOfProduct"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  totalOrderAmount(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetTotalOrderAmount?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["totalOrderAmount"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
totalODConfirmed() async {
    num sum = 0;
    List<InvoiceSupplier> inv = await fetchAllOrderdetail(widget.invoice.id);
    for (int i = 0; i < inv.length; i++) {
      if (inv[i].isStatus != 3 && inv[i].isStatus !=2) {
        num e = inv[i].price!;
        sum += e;
      }
      else{
        continue;
      }
    }

    return sum;
  }

 discountForILAConfirmed() async {
    num dis = await totalODConfirmed() * 1 / 10;

    return dis.toStringAsFixed(2);
  }

  

  Future totalOfSupplierConfirmed() async {
    num prvch ;
    final b = await fetchVoucherPrice(widget.invoice.voucherS);
    if(b == "0"){
      prvch = 0;
    }else{
      prvch = num.parse(b.toString());
    }
    final d = await discountForILAConfirmed();
    final e = await totalODConfirmed();
    num c = num.parse(e.toString()) -num.parse(d.toString()) - prvch ;
    num up;
    if (c >= 0) {
      up = c;
    } else {
      up = 0;
    }
    return up.toStringAsFixed(2);
  }

 

  Future<String> fetchVoucherPrice(lsvoucher) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/Voucher/getPriceVoucherInSupplierInvoice?idSupplier=$ids&lsVoucherS=$lsvoucher '));

    if (response.statusCode == 200) {
      print("vouchersup   " + response.body);
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  refundtoCustomer(idinvoice) async {
    var ids = await getIdSup();
    final response = await http.get(Uri.parse(
        '$u/api/InvoiceSupplier/GetRefundtoCustomers?idSupplier=$ids&idInvoice=$idinvoice'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse[0]["refundtoCustomers"];
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}


unitprice(price, amount) {
  num a;
  a = (price / amount);
  return a;
}

import 'package:coffee/bundle.dart';

import 'package:coffee/src/orderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InvoiceSupplier {
  int? id;
  String? nameCus;
  String? createDate;
  int? isStatus;
  String? nameProduct;
  double? unitPrice;
  int? idInvoice;
  double? priceVoucherA;
  double? amountReceived;
  double? totalA;
  double? totalS;
  double? priceOrder;
  int? idInvoiceDetail;
  String? address;
  int? idSupplier;
  int? phone;
  String? titleSup;
  int? status;
  double? refundtoCustomers;
  double? totalOrderAmount;
  double? totalAmountOfProduct;
  int? price;
  int? idInvoiceSup;
  double? totalPrice;
  String? voucherS;
  String? voucherA;
  int? amount;
  String? image;
  InvoiceSupplier(
      {this.id,
      this.nameCus,
      this.createDate,
      this.isStatus,
      this.nameProduct,
      this.unitPrice,
      this.idInvoice,
      this.priceVoucherA,
      this.amountReceived,
      this.totalA,
      this.totalS,
      this.priceOrder,
      this.idInvoiceDetail,
      this.address,
      this.idSupplier,
      this.phone,
      this.titleSup,
      this.status,
      this.idInvoiceSup,
      this.refundtoCustomers,
      this.totalOrderAmount,
      this.totalAmountOfProduct,
      this.price,
      this.totalPrice,
      this.voucherS,
      this.voucherA,
      this.amount,
      this.image});

  InvoiceSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameCus = json['nameCus'];
    createDate = json['createDate'];
    isStatus = json['isStatus'];
    nameProduct = json['nameProduct'];
    unitPrice = json['unitPrice'];
    idInvoice = json['idInvoice'];
    priceVoucherA = json['priceVoucherA'];
    amountReceived = json['amountReceived'];
    totalA = json['totalA'];
    totalS = json['totalS'];
    priceOrder = json['priceOrder'];
    idInvoiceDetail = json['idInvoiceDetail'];
    address = json['address'];
    idSupplier = json['idSupplier'];
    phone = json['phone'];
    titleSup = json['titleSup'];
    status = json['status'];
    refundtoCustomers = json['refundtoCustomers'];
    totalOrderAmount = json['totalOrderAmount'];
    totalAmountOfProduct = json['totalAmountOfProduct'];
    price = json['price'];
    totalPrice = json['totalPrice'];
    voucherS = json['voucherS'];
    voucherA = json['voucherA'];
    amount = json['amount'];
    image = json['image'];
  }
}

class Order extends StatefulWidget {
  int initialPage; //this sets the innitial page to open when main class opens. ie if a main class is opened from secondpage and innitialPage is set to 1 then it will show the second page as the tabpages start from 0.

  Order({required this.initialPage});
  @override
  State<Order> createState() => _Order();
}

class _Order extends State<Order> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool press0 = false;
  bool press1 = true;
  bool press2 = true;
  bool press3 = true;
  var isActi;
  List id = [];
  @override
  void initState() {
    _tabController =
        TabController(length: 5, vsync: this, initialIndex: widget.initialPage);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nextPage(widget.initialPage);
    super.dispose();
  }

  void _nextPage(int tab) {
    final int newTab = _tabController.index + tab;
    if (newTab < 0 || newTab >= _tabController.length) return;
    _tabController.animateTo(newTab);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Dashboard()));
                },
                icon: Icon(Icons.arrow_back_ios)),
            toolbarHeight: 70,
            centerTitle: true,
            title: Text(
              "ORDER",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              tabAlignment: TabAlignment.start ,
              
                controller: _tabController,
                labelColor: Color.fromARGB(255, 181, 57, 5),
                unselectedLabelColor: Colors.black.withOpacity(0.5),
                isScrollable: true,
                indicatorPadding: EdgeInsets.all(0),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 3, color: Color.fromARGB(255, 181, 57, 5)),
                ),
                labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                tabs: [
                  
                  Tab(
                    text: "Waiting",
                  ),
                  Tab(
                    text: "Delivering",
                  ),
                  Tab(
                    text: "Delivered",
                  ),
                  Tab(
                    text: "Cancelled",
                  ),
                  Tab(
                    text: "Review of order",
                  )
                ]),
                
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              OrderWidget1(),
              OrderWidget2(),
              OrderWidget3(),
              OrderWidget4(),
              OrderWidget5(),
            ],
          )),
    );
  }
}

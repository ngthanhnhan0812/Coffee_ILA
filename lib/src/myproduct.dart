import 'dart:convert';
import 'dart:io';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/itemsWidget.dart';
import 'package:coffee/src/marketing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Product {
  final int id;
  final String title;
  final String image;
  final String? image1;
  final String? image2;
  final String? image3;
  final String description;
  final int price;
  final int idSupplier;
  final int isActive;
  final int idCate;
  const Product(
      {required this.id,
      required this.title,
      required this.image,
      required this.image1,
      required this.image2,
      required this.image3,
      required this.description,
      required this.price,
      required this.idSupplier,
      required this.isActive,
      required this.idCate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        image1: json['image1'],
        image2: json['image2'],
        image3: json['image3'],
        description: json['description'],
        price: json['price'],
        idSupplier: json['idSupplier'],
        isActive: json['isActive'],
        idCate: json['idcate']);
  }
}

class Myproduct extends StatefulWidget {
  int initialPage; //this sets the innitial page to open when main class opens. ie if a main class is opened from secondpage and innitialPage is set to 1 then it will show the second page as the tabpages start from 0.

  Myproduct({required this.initialPage});
  @override
  State<Myproduct> createState() => _Myproduct();
}

class _Myproduct extends State<Myproduct> with SingleTickerProviderStateMixin {
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
        TabController(length: 4, vsync: this, initialIndex: widget.initialPage);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Dashboard()));
            },
            icon: Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        centerTitle: true,
        title: Text(
          "MY PRODUCTS",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
            controller: _tabController,
          
            labelColor: Color.fromARGB(255, 181, 57, 5),
            unselectedLabelColor: Colors.black.withOpacity(0.5),
            isScrollable: false,
            labelPadding:EdgeInsets.all(0),
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(width: 3, color: Color.fromARGB(255, 181, 57, 5)),
            ),
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: "Approved",
              ),
              Tab(
                text: "Waiting",
              ),
              Tab(
                text: "Cancelled",
              ),
              Tab(
                text: "Hidden",
              )
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          RefreshIndicator(child: ItemsWidget1(), onRefresh: _refresh),
          RefreshIndicator(child: ItemsWidget0(), onRefresh: _refresh),
          RefreshIndicator(child: ItemsWidget2(), onRefresh: _refresh),
          RefreshIndicator(child: ItemsWidget3(), onRefresh: _refresh),
        ],
      ),
      floatingActionButton: Container(
        height: 40,
        width: 40,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 250, 211, 211),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Addproduct()),
            );
          },
          child: Icon(
            Icons.add,
            size: 25,
            color: Color.fromARGB(255, 181, 57, 5),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Container(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: Icon(
                  Icons.home,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Myproduct(initialPage: 0)));
                },
                child: Icon(
                  Icons.view_cozy,
                  color: Color.fromARGB(255, 181, 57, 5),
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {},
                child: Icon(
                  Icons.leaderboard,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Marketing(containSelectedBox: [],)));
                },
                child: Icon(
                  Icons.api_sharp,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {},
                child: Icon(
                  Icons.app_registration,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setpress0() {
    if (press0 = true) {
      setState(() {
        press0 = false;
        press1 = true;
        press2 = true;
        press3 = true;
      });
    } else {
      press0 = false;
      press1 = true;
      press2 = true;
      press3 = true;
    }
  }

  setpress1() {
    if (press1 = true) {
      setState(() {
        press1 = false;
        press0 = true;
        press2 = true;
        press3 = true;
      });
    } else {
      press1 = false;
      press0 = true;
      press2 = true;
      press3 = true;
    }
  }

  setpress2() {
    if (press2 = true) {
      setState(() {
        press2 = false;
        press0 = true;
        press1 = true;
        press3 = true;
      });
    } else {
      press2 = false;
      press0 = true;
      press1 = true;
      press3 = true;
    }
  }

  setpress3() {
    if (press3 = true) {
      setState(() {
        press3 = false;
        press1 = true;
        press2 = true;
        press0 = true;
      });
    } else {
      press3 = false;
      press1 = true;
      press2 = true;
      press0 = true;
    }
  }

  getIdp(idd) {
    setState(() {
      id.add(idd);
    });
  }

  fetchCountisActive(active) async {
    final response = await http.get(Uri.parse(
        '$u/Supplier/CountFilterActive?idSupplier=2&isActive=$active '));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Product>> fetchProduct(isActi) async {
    final response = await http.get(
        Uri.parse('$u/Supplier/FilterActive?isActive=$isActi&idSupplier=2'));

    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);

      return jsonResponse.map((data) => Product.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<void> hiddenp() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Hidden Product',
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Myproduct(
                            initialPage: 3,
                          )));
                },
              ),
            ],
          );
        });
  }

  Future<void> _refresh() {
    return Future.delayed(Duration(seconds: 1));
  }

  Future<http.Response> hideProduct(int idprod) async {
    var p = new Map();
    p['id'] = idprod;
    p['isActive'] = 3;
    final response = await http.post(Uri.parse('$u/Admin/UpdateActiveProd'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(p));

    return response;
  }
}

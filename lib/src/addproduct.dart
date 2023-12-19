import 'dart:convert';
import 'dart:io';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<List<Category>> fetchCategory() async {
  final response =
      await http.get(Uri.parse('$u/api/Category/cateNew'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);

    return jsonResponse.map((data) => Category.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Category {
  int? id;
  String? title;
  String? createDate;
  bool? active;

  Category({this.id, this.title, this.createDate, this.active});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createDate = json['createDate'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['createDate'] = this.createDate;
    data['active'] = this.active;
    return data;
  }
}

class Addproduct extends StatefulWidget {
  @override
  _Addproduct createState() => _Addproduct();
}

class _Addproduct extends State<Addproduct> {
  String? dropdownvalue;
  final _formKey = GlobalKey<FormState>();
  final storage = FirebaseStorage.instance;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  List<File> _image = [];
  File? im = null;
  File? im1 = null;
  File? im2 = null;
  File? im3 = null;
  bool nofile = false;
  final TextEditingController _nameproduct = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  var idcate;

  final picker = ImagePicker();
  var selectValue;
  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imgdl');
  }

  
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return _onWillPop();
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 243, 243),
        appBar: AppBar(
          shadowColor: Color.fromARGB(255, 203, 203, 203),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            'ADD PRODUCT',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 181, 57, 5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: 25,
              )),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                      color: Colors.white,
                      margin: EdgeInsets.fromLTRB(7, 5, 7, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Images',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  child: im == null
                                      ? Container(
                                          height: 70,
                                          width: 70,
                                          color: const Color.fromARGB(
                                              255, 242, 242, 242),
                                          child: CupertinoButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 150,
                                                        child: Column(
                                                          children: [
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Take a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  takeImage();
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .image,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Pick a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  chooseImage();
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }),
                                        )
                                      : Container(
                                          child: Stack(children: [
                                            SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: Image(
                                                  image: FileImage(im!),
                                                  fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              child: IconButton(
                                                  onPressed: () {
                                                    removeImage1(im!);
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                    size: 17,
                                                  )),
                                              top: -12,
                                              right: -12,
                                            )
                                          ]),
                                        ),
                                ),
                                SizedBox(
                                  child: im1 == null
                                      ? Container(
                                          height: 70,
                                          width: 70,
                                          color: const Color.fromARGB(
                                              255, 242, 242, 242),
                                          child: CupertinoButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 150,
                                                        child: Column(
                                                          children: [
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Take a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  takeImage1();
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .image,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Pick a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  chooseImage1();
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(3),
                                          child: Stack(children: [
                                            SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: Image(
                                                  image: FileImage(im1!),
                                                  fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              child: IconButton(
                                                  onPressed: () {
                                                    removeImage2(im1!);
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                    size: 17,
                                                  )),
                                              top: -12,
                                              right: 2,
                                            )
                                          ]),
                                        ),
                                ),
                                SizedBox(
                                  child: im2 == null
                                      ? Container(
                                          height: 70,
                                          width: 70,
                                          color:
                                              Color.fromARGB(255, 242, 242, 242),
                                          child: CupertinoButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 150,
                                                        child: Column(
                                                          children: [
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Take a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  takeImage2();
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .image,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Pick a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  chooseImage2();
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(3),
                                          child: Stack(children: [
                                            SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: Image(
                                                  image: FileImage(im2!),
                                                  fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              child: IconButton(
                                                  onPressed: () {
                                                    removeImage3(im2!);
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                    size: 17,
                                                  )),
                                              top: -12,
                                              right: 2,
                                            )
                                          ]),
                                        ),
                                ),
                                SizedBox(
                                  child: im3 == null
                                      ? Container(
                                          height: 70,
                                          width: 70,
                                          color:
                                              Color.fromARGB(255, 242, 242, 242),
                                          child: CupertinoButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                showModalBottomSheet<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Container(
                                                        height: 150,
                                                        child: Column(
                                                          children: [
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .camera_alt,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Take a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  takeImage3();
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                            CupertinoButton(
                                                                child: Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        backgroundColor: Color.fromARGB(
                                                                            255,
                                                                            212,
                                                                            212,
                                                                            212),
                                                                        radius:
                                                                            15,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .image,
                                                                          size:
                                                                              15,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 15,
                                                                      ),
                                                                      Text(
                                                                        "Pick a photo",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                17,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )
                                                                    ]),
                                                                onPressed: () {
                                                                  chooseImage3();
                                                                  Navigator.pop(
                                                                      context);
                                                                })
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              }),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(3),
                                          child: Stack(children: [
                                            SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: Image(
                                                  image: FileImage(im3!),
                                                  fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              child: IconButton(
                                                  onPressed: () {
                                                    removeImage4(im3!);
                                                  },
                                                  icon: const Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                    size: 17,
                                                  )),
                                              top: -12,
                                              right: 2,
                                            )
                                          ]),
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            nofile
                                ? SizedBox()
                                : Text('Please pick enough photos',style: TextStyle(color: const Color.fromARGB(255, 171, 29, 19),fontSize: 12),)
                          ],
                        ),
                      )),
                  Container(
                    height: 110,
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(7, 5, 7, 0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name Product',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                 inputFormatters: [
                              
                              FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                            ],
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                controller: _nameproduct,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter name product';
                                  }
                                  if (value.length >= 50) {
                                    return 'Name product is too long';
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9_.,!-;][a-zA-Z0-9\s_.,!-;]+$")
                                      .hasMatch(value)) {
                                    return 'Name product is not accepted';
                                  }
                                  return null; // Return null if the validation is successful
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(7, 5, 7, 0),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descriptions',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            decoration: InputDecoration(border: InputBorder.none),
                            maxLength: 2000,
                            maxLines: null,
                             inputFormatters: [
                              
                              FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                            ],
                            keyboardType: TextInputType.multiline,
                            controller: _description,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter  description';
                              }
      
                              if (!RegExp(
                                      r"^[a-zA-Z0-9_.,!-;][a-zA-Z0-9\s_.,!-;]+$")
                                  .hasMatch(value)) {
                                return 'Description is not accepted';
                              }
                              return null; // Return null if the validation is successful
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(7, 5, 7, 0),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Category',
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold)),
                              FutureBuilder(
                                  future: fetchCategory(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var dat = snapshot.data!;
                                      return DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          hint: Row(
                                            children: [
                                              Icon(Icons.list),
                                              Text('Select Category')
                                            ],
                                          ),
                                          menuMaxHeight: 400,
                                          value: selectValue,
                                          isExpanded: true,
                                          items: dat.map((e) {
                                            return DropdownMenuItem(
                                              value: e.id.toString(),
                                              child: Text(e.title.toString()),
                                            );
                                          }).toList(),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select category.';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            selectValue = value;
                                            setState(() {
                                              idcate = selectValue;
                                            });
                                          });
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }
                                    // By default show a loading spinner.
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    height: 110,
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(7, 5, 7, 0),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                controller: _price,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter  price';
                                  }
      
                                  if (!RegExp(r"^[1-9][0-9]*$")
                                      .hasMatch(value)) {
                                    return 'Price is not accepted';
                                  }
                                  return null; // Return null if the validation is successful
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 300, // <-- match_parent
      
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 181, 57, 5),
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            addpro();
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addpro() async {
    if (_image.length < 4 ||
        _nameproduct.text == '' ||
        _description.text == '' ||
        idcate == null ||
        _price.text == '') {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Add Product',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Failed'),
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
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
      await getImageUrl().whenComplete(
        () {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Add Product',
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
                          builder: (context) => Myproduct(initialPage: 1)));
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

  nopick() {
    if (_image.length < 4) {
      setState(() {
        nofile = false;
      });
    } else {
      setState(() {
        nofile = true;
      });
    }
  }

  chooseImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    final filePath = pickedFile!.path;
    print(filePath);
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);

    setState(() {
      im = File(compressedImage!.path);
      _image.add(im!);
    });
    nopick();
  }

  takeImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 30);

    final filePath = pickedFile!.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);
    setState(() {
      im = File(compressedImage!.path);
      _image.add(im!);
    });
    nopick();
    print(im);
  }

  chooseImage1() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    final filePath = pickedFile!.path;
    print(filePath);
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);

    setState(() {
      im1 = File(compressedImage!.path);
      _image.add(im1!);
    });
    nopick();
  }

  takeImage1() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 30);

    final filePath = pickedFile!.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);
    setState(() {
      im1 = File(compressedImage!.path);
      _image.add(im1!);
    });
    nopick();
  }

  chooseImage2() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    final filePath = pickedFile!.path;
    print(filePath);
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);

    setState(() {
      im2 = File(compressedImage!.path);
      _image.add(im2!);
    });
    nopick();
  }

  takeImage2() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 30);

    final filePath = pickedFile!.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);
    setState(() {
      im2 = File(compressedImage!.path);
      _image.add(im2!);
    });
    nopick();
  }

  chooseImage3() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    final filePath = pickedFile!.path;
    print(filePath);
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);

    setState(() {
      im3 = File(compressedImage!.path);
      _image.add(im3!);
    });
    nopick();
  }

  takeImage3() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 30);

    final filePath = pickedFile!.path;

    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);
    setState(() {
      im3 = File(compressedImage!.path);
      _image.add(im3!);
    });
    nopick();
  }

  removeImage1(File imm) async {
    setState(() {
      im = null;
      _image.remove(imm);
    });
    print(_image.length);
    nopick();
  }

  removeImage2(File imm) async {
    setState(() {
      im1 = null;
      _image.remove(imm);
    });
    nopick();
  }

  removeImage3(File imm) async {
    setState(() {
      im2 = null;
      _image.remove(imm);
    });
    nopick();
  }

  removeImage4(File imm) async {
    setState(() {
      im3 = null;
      _image.remove(imm);
    });
    nopick();
    print(im);
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  UploadTask? uploadTask;
  final metadata = SettableMetadata(contentType: "image/jpeg");
  Future<http.Response> getImageUrl() async {
    List<String> imagesUrls = [];
    final rg = RegExp(r'-');
List <File?> abc = [im,im1,im2,im3];
    for (var img in abc) {
      var uuid = Uuid();
      String a = uuid.v1().trim().replaceAll(rg, '');
      final String imagePath = '${a+'.jpg'}';
      final file = File(img!.path);
      final ref =
          FirebaseStorage.instance.ref().child(path.basename(imagePath));
      uploadTask = ref.putFile(file, metadata);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urldownload = await snapshot.ref.getDownloadURL();
      imagesUrls.add(urldownload);
    }
 final regex = RegExp(r'\s+');
    print('get imageurl success');
    var dt = new Map();

    dt['title'] = _nameproduct.text.trim().replaceAll(regex, ' ');
    dt['image'] = imagesUrls[0];

    for (int i = 1; i < imagesUrls.length; i++) {
      dt['image$i'] = imagesUrls[i];
    }
    dt['description'] = _description.text.trim().replaceAll(regex, ' ');
    dt['price'] = int.parse(_price.text);
    dt['idSupplier'] = '2';
    dt['isActive'] = '0';
    dt['idcate'] = idcate;

    final response =
        await http.post(Uri.parse('$u/api/Supplier/Products/insertNewProduct'),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            body: jsonEncode(dt));
    print(response.body);
    return response;
  }
  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Back'),
                content: const Text('Are you sure you want to go back?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }, //<-- SEE HERE
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Myproduct(initialPage: 0)));
                    }, //<-- SEE HERE
                    child: const Text('Yes'),
                  ),
                ],
              );
            }) ??
        false);
  }

}

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  EditProduct({Key? key, required this.product}) : super(key: key);
  @override
  _EditProduct createState() => _EditProduct();
}

class _EditProduct extends State<EditProduct> {
  final storage = FirebaseStorage.instance;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  List<String> imm = [];

  List<File> _image = [];
  bool noimg = true;
  File? im = null;
  File? im1 = null;
  File? im2 = null;
  File? im3 = null;
  String? imm0;
  String? imm1;
  String? imm2;
  String? imm3;
  String i0 = "x";
  String i1 = "x";
  String i2 = "x";
  String i3 = "x";
  bool one = true;
  bool two = true;
  bool three = true;
  bool four = true;
  final TextEditingController _nameproduct = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  var idcate;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  var selectValue;

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imgdl');
    imm0 = widget.product.image;
    imm1 = widget.product.image1;
    imm2 = widget.product.image2;
    imm3 = widget.product.image3;
    _nameproduct.text = widget.product.title;
    _description.text = widget.product.description;
    _price.text = widget.product.price.toString();
    selectValue = widget.product.idCate;
    idcate = selectValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 243, 243),
      appBar: AppBar(
        shadowColor: Color.fromARGB(255, 203, 203, 203),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(
          'EDIT PRODUCT',
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
                              i0 == 'x'
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Image.network(
                                            imm0.toString(),
                                            errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  i0 = 'nx';
                                                  one = false;
                                                  noimage();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                                size: 17,
                                              )),
                                          top: -12,
                                          right: -12,
                                        )
                                      ],
                                    )
                                  : im == null
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
                                                                        width:
                                                                            15,
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
                                                                        width:
                                                                            15,
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
                              i1 == 'x'
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Image.network(
                                            imm1.toString(),
                                            errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  i1 = 'nx';
                                                  two = false;
                                                  noimage();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                                size: 17,
                                              )),
                                          top: -12,
                                          right: -12,
                                        )
                                      ],
                                    )
                                  : im1 == null
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
                                                                        width:
                                                                            15,
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
                                                                        width:
                                                                            15,
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
                                              right: -12,
                                            )
                                          ]),
                                        ),
                              i2 == 'x'
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Image.network(
                                            imm2.toString(),
                                            errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  i2 = 'nx';
                                                  three = false;
                                                  noimage();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                                size: 17,
                                              )),
                                          top: -12,
                                          right: -12,
                                        )
                                      ],
                                    )
                                  : im2 == null
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
                                                                        width:
                                                                            15,
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
                                                                        width:
                                                                            15,
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
                                              right: -12,
                                            )
                                          ]),
                                        ),
                              i3 == 'x'
                                  ? Stack(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          width: 70,
                                          child: Image.network(
                                            imm3.toString(),
                                            errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  i3 = 'nx';
                                                  four = false;
                                                  noimage();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                                color: Colors.white,
                                                size: 17,
                                              )),
                                          top: -12,
                                          right: -12,
                                        )
                                      ],
                                    )
                                  : im3 == null
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
                                                                        width:
                                                                            15,
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
                                                                        width:
                                                                            15,
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
                                              right: -12,
                                            )
                                          ]),
                                        ),
                            ],
                          )
                         ,SizedBox(
                            height: 5,
                          ),
                         noimg? SizedBox():Text("Please pick enough photos",style: TextStyle(color: Color.fromARGB(255, 162, 30, 21),fontSize: 12),)
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
                              controller: _nameproduct,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name product';
                                }
                                if (value.length > 50) {
                                  return 'Name product is too long';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9_.,!-;][a-zA-Z0-9\s_.,!-;]+$")
                                    .hasMatch(value)) {
                                  return 'Name product is not accepted';
                                }
                                return null; // Return null if the validation is successful
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
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
                          'Description',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                           inputFormatters: [
                            
                            FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                          ],
                          maxLength: 2000,
                          keyboardType: TextInputType.multiline,
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
                          maxLines: null,
                          controller: _description,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
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
                                        value: selectValue.toString(),
                                        isExpanded: true,
                                        menuMaxHeight: 400,
                                        items: dat.map((e) {
                                          return DropdownMenuItem(
                                            value: e.id.toString(),
                                            child: Text(e.title.toString()),
                                          );
                                        }).toList(),
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
                              controller: _price,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter  price';
                                }

                                if (!RegExp(r"^[1-9][0-9]*$").hasMatch(value)) {
                                  return 'Price is not accepted';
                                }
                                return null; // Return null if the validation is successful
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
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
                          editpro();
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
    );
  }

  noimage() {
    if (one == false || two == false || three == false || four == false) {
      setState(() {
        noimg = false;
      });
    } else {
      setState(() {
        noimg = true;
      });
    }
  }

  Future<void> editpro() async {
    if (noimg == false||
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
              'Edit Product',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Failed'),
                   Text('Please pick enough photos'),
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
                  'Edit Product',
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
                          builder: (context) => Myproduct(initialPage: 0)));
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

  Future deletefile(String url) async {
    ref = FirebaseStorage.instance.refFromURL(url);
    await ref.delete();
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
      one = true;
    });
    noimage();
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
      one = true;
    });
    noimage();
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
      two = true;
    });
    noimage();
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
      two = true;
    });
    noimage();
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
      three = true;
    });
    noimage();
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
      three = true;
    });
    noimage();
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
      four = true;
    });
    noimage();
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
      four = true;
    });
    noimage();
  }

  removeImage1(File imm) async {
    setState(() {
      im = null;
      one = false;
    });
    noimage();
  }

  removeImage2(File imm) async {
    setState(() {
      im1 = null;
      two = false;
    });
    noimage();
  }

  removeImage3(File imm) async {
    setState(() {
      im2 = null;
      _image.remove(imm);
      three = false;
    });
    noimage();
  }

  removeImage4(File imm) async {
    setState(() {
      im3 = null;
      four = false;
    });
    noimage();
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

  final metadata = SettableMetadata(contentType: "image/jpeg");
  UploadTask? uploadTask;
  Future<http.Response> getImageUrl() async {
    List<String> imagesUrls = [];
    if (im != null) {
      _image.add(im!);
    }
    if (im1 != null) {
      _image.add(im1!);
    }
    if (im2 != null) {
      _image.add(im2!);
    }
    if (im3 != null) {
      _image.add(im3!);
    }
    if (_image.isNotEmpty) {
      for (var img in _image) {
        final file = File(img.path);
         final String imagePath = 'images/${DateTime.now()}.jpg';
        final ref =
            FirebaseStorage.instance.ref().child(path.basename(imagePath));
        uploadTask = ref.putFile(file, metadata);
        final snapshot = await uploadTask!.whenComplete(() {});
        final urldownload = await snapshot.ref.getDownloadURL();
        imagesUrls.add(urldownload);
      }
    }

    List<String> a = [i0, i1, i2, i3];
    List<String> b = [imm0!, imm1!, imm2!, imm3!];
    for (int i = 0; i < 4; i++) {
      if (a[i] == 'nx') {
        setState(() {
          a[i] = imagesUrls[0];
          deletefile(b[i]);
          b[i] = imagesUrls[0];
          imagesUrls.remove(imagesUrls[0]);
        });
      }
    }
    for (int i = 0; i < 4; i++) {
      if (a[i] == 'x') {
        setState(() {
          a[i] = b[i];
        });
      }
    }
     final regex = RegExp(r'\s+');
    print('get imageurl success');
    var dt = new Map();
    dt['id'] = widget.product.id;
    dt['title'] = _nameproduct.text.trim().replaceAll(regex, ' ');
    dt['image'] = a[0];
    dt['image1'] = a[1];
    dt['image2'] = a[2];
    dt['image3'] = a[3];
    dt['description'] = _description.text.trim().replaceAll(regex, ' ');
    dt['price'] = int.parse(_price.text);
    dt['isActive'] = 0;
    dt['idcate'] = idcate;

    final response = await http.post(
        Uri.parse('$u/api/Supplier/Products/supplierUpdateProduct'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(dt));
    print(imm);
    return response;
  }
}

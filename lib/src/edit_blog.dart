// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/blog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:coffee/src/models/blog.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class Edit_Blog extends StatefulWidget {
  final Blog blog;
  const Edit_Blog({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  State<Edit_Blog> createState() => _Edit_BlogState();
}

// ignore: camel_case_types
class _Edit_BlogState extends State<Edit_Blog> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final storage = FirebaseStorage.instance;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  bool noimg = false;
  String? _image;
  bool _im = true;
  File? img;
  final picker = ImagePicker();
  bool imgCheck = true;
  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imgdl');
    _title.text = widget.blog.title.toString();
    _description.text = widget.blog.description.toString();
    _image = widget.blog.image;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 243, 243),
        appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 203, 203, 203),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Text(
            'Edit Blog',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 181, 57, 5),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left, color: Colors.black)),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Center(
                    child: SizedBox(
                  child: _im
                      ? Stack(
                          children: [
                            SizedBox(
                              height: 300,
                              width: 360,
                              child: Image.network(
                                _image.toString(),
                              ),
                            ),
                            Positioned(
                              top: -12,
                              right: -12,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _im = false;
                                      imgCheck = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                    size: 17,
                                  )),
                            )
                          ],
                        )
                      : img == null
                          ? Container(
                              height: 70,
                              width: 70,
                              color: const Color.fromARGB(255, 242, 242, 242),
                              child: CupertinoButton(
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 150,
                                            child: Column(
                                              children: [
                                                CupertinoButton(
                                                    child: const Row(children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                212, 212, 212),
                                                        radius: 15,
                                                        child: Icon(
                                                          Icons.camera_alt,
                                                          size: 20,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        "Take a photo",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ]),
                                                    onPressed: () {
                                                      takeImage();
                                                      Navigator.pop(context);
                                                    }),
                                                CupertinoButton(
                                                    child: const Row(children: [
                                                      CircleAvatar(
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                212, 212, 212),
                                                        radius: 15,
                                                        child: Icon(
                                                          Icons.image,
                                                          size: 15,
                                                          color: Color.fromARGB(
                                                              255, 0, 0, 0),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(
                                                        "Pick a photo",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ]),
                                                    onPressed: () {
                                                      chooseImage();
                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            ),
                                          );
                                        });
                                  }),
                            )
                          : Stack(children: [
                              SizedBox(
                                height: 300,
                                width: 360,
                                child: Image(image: FileImage(img!)),
                              ),
                              Positioned(
                                top: -12,
                                right: -12,
                                child: IconButton(
                                    onPressed: () {
                                      removeImage();
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.black,
                                      size: 20,
                                    )),
                              )
                            ]),
                )),
                Container(
                  margin: const EdgeInsets.fromLTRB(7, 5, 7, 0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title here';
                            } else if (value.length > 50) {
                              return 'The limitation of title is 50';
                            } else if (value.contains('  ')) {
                              return 'Check your space between';
                            }
                            return null;
                          },
                          maxLength: 50,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50),
                            FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                          ],
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          controller: _title,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(7, 5, 7, 0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Content',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter content here';
                            } else if (value.length > 2000) {
                              return 'The limitation of description is 2000';
                            } else if (value.contains('  ')) {
                              return 'Check your space between';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          maxLength: 2000,
                          maxLines: null,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2000),
                            FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                          ],
                          keyboardType: TextInputType.multiline,
                          controller: _description,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          Row(children: [
            const VerticalDivider(color: Color.fromARGB(255, 244, 243, 243)),
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                updateBlogDialog();
              },
              child: const Text('Update', textAlign: TextAlign.center),
            ))
          ]),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  // CheckImageSelected() {
  //   if (img == null) {
  //     setState(() {
  //       imgCheck = false;
  //     });
  //   } else {
  //     setState(() {
  //       imgCheck = true;
  //     });
  //   }
  // }

  chooseImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    final filePath = pickedFile!.path;
    print(filePath);
    final lastIndex = filePath.lastIndexOf(RegExp(r'\.([a-zA-Z]+)'));
    final extension = filePath.substring(lastIndex);
    final split = filePath.substring(0, (lastIndex));
    final outPath = "${split}_out$extension";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);

    setState(() {
      img = File(compressedImage!.path);
      imgCheck = true;
    });
  }

  takeImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 30);

    final filePath = pickedFile!.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);
    setState(() {
      img = File(compressedImage!.path);
      imgCheck = true;
    });
  }

  removeImage() async {
    setState(() {
      img = null;
      imgCheck = false;
    });
  }

  UploadTask? uploadTask;
  Future<http.Response> updateBlog() async {
    final metadata = SettableMetadata(contentType: "image/jpeg");
    if (img != null) {
      final getImg = FirebaseStorage.instance.refFromURL(_image.toString());
      await getImg.delete();
      final String imagePath = 'images/${DateTime.now()}.jpg';
      final file = File(img!.path);
      final ref =
          FirebaseStorage.instance.ref().child(path.basename(imagePath));
      uploadTask = ref.putFile(file, metadata);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      setState(() {
        _image = urlDownload;
      });
    }

    var bg = {};
    bg['id'] = widget.blog.id;
    bg['title'] = _title.text;
    bg['description'] = _description.text;
    bg['image'] = _image;
    bg['createDate'] = DateFormat('yyyy-MM-dd').format(DateTime.now());
    bg['isStatus'] = widget.blog.isStatus;

    final response = await http.post(Uri.parse('$u/api/Blog/updateBlog'),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(bg));
    print('Edit Blog successfully!');
    return response;
  }

  Future<void> updateBlogDialog() async {
    // ignore: unrelated_type_equality_checks
    if (imgCheck == false || _title.text == '' || _description.text == '') {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Edit Blog',
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
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );
      try {
        await Future.delayed(const Duration(seconds: 2));
      } finally {
        await updateBlog().whenComplete(
          () {
            return showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Edit Blog',
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
                        if (widget.blog.isStatus == 0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlogView(ind: 1)));
                        } else if (widget.blog.isStatus == 1) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlogView(ind: 0)));
                        }
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
  }
}

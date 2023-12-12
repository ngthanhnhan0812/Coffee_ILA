import 'dart:convert';
import 'dart:io';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'package:coffee/src/sidebar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:image_picker/image_picker.dart';


class Editprofile extends StatefulWidget {
  final Supplier profile;
  Editprofile({Key? key, required this.profile}) : super(key: key);
  @override
  State<Editprofile> createState() => _Editprofile();
}

class _Editprofile extends State<Editprofile> {
  bool isloading = false;
  String? _avatar;
  File? avt = null;
  String? _image;
  File? img = null;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _username = TextEditingController();
  String? password;
  var idcate;

  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _image = widget.profile.image;
    _avatar = widget.profile.avatar;
    _title.text = widget.profile.title.toString();
    _address.text = widget.profile.address.toString();
    _phone.text = widget.profile.phone.toString();
    _email.text = widget.profile.email.toString();
    _username.text = widget.profile.username.toString();
    password = widget.profile.password.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 240,
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        width: 380,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 181, 57, 5)),
                        child: img == null
                            ? Image.network(
                                _image.toString(),
                                errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
                                fit: BoxFit.cover,
                              )
                            : Image(
                                image: FileImage(img!),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                          bottom: 10,
                          left: 13,
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80)),
                                color: Color.fromARGB(255, 181, 57, 5),
                                image: avt == null
                                    ? DecorationImage(
                                      
                                        image: NetworkImage(_avatar!),
                                        fit: BoxFit.cover)
                                    : DecorationImage(
                                        image: FileImage(avt!),
                                        fit: BoxFit.fill)),
                          )),
                      Positioned(
                          bottom: 20,
                          left: 115,
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  Color.fromARGB(255, 212, 212, 212),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 15,
                                ),
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              CupertinoButton(
                                                  child: Row(children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              212, 212, 212),
                                                      radius: 15,
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        size: 15,
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
                                                              FontWeight.w400),
                                                    )
                                                  ]),
                                                  onPressed: () {
                                                    takeAvatar();
                                                    Navigator.pop(context);
                                                  }),
                                              CupertinoButton(
                                                  child: Row(children: [
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
                                                              FontWeight.w400),
                                                    )
                                                  ]),
                                                  onPressed: () {
                                                    chooseAvatar();
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ))),
                      Positioned(
                          bottom: 50,
                          right: 10,
                          child: CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  Color.fromARGB(255, 212, 212, 212),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  size: 15,
                                ),
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              CupertinoButton(
                                                  child: Row(children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              212, 212, 212),
                                                      radius: 15,
                                                      child: Icon(
                                                        Icons.camera_alt,
                                                        size: 15,
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
                                                              FontWeight.w400),
                                                    )
                                                  ]),
                                                  onPressed: () {
                                                    takeImage();
                                                    Navigator.pop(context);
                                                  }),
                                              CupertinoButton(
                                                  child: Row(children: [
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
                                                              FontWeight.w400),
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
                                },
                              )))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.api_sharp,
                              size: 13,
                              color: Color.fromARGB(255, 155, 155, 155),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Title',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 155, 155),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                           inputFormatters: [
                            
                            FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                          ],
                          controller: _title,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            if (value.length >= 50) {
                              return 'Title is too long';
                            }
                            if (!RegExp(r"^[a-zA-Z0-9][a-zA-Z0-9\s]+$")
                                .hasMatch(value)) {
                              return 'Title is not accepted';
                            }
                            return null; // Return null if the validation is successful
                          },
                        ),
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 236, 235, 235),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 13,
                              color: Color.fromARGB(255, 155, 155, 155),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Phone',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 155, 155),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            controller: _phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              if (value.length >= 10) {
                                return 'Enter a valid phone number';
                              }
                              if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                return 'Enter a valid phone number';
                              }

                              return null; // Return null if the validation is successful
                            },
                            keyboardType: TextInputType.phone),
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 236, 235, 235),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 13,
                              color: Color.fromARGB(255, 155, 155, 155),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 155, 155),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: _email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            if (value.length >= 50) {
                              return 'Email address is too long';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                .hasMatch(value)) {
                              return 'Enter a valid email address';
                            }

                            return null; // Return null if the validation is successful
                          },
                        ),
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 236, 235, 235),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.map,
                              size: 13,
                              color: Color.fromARGB(255, 155, 155, 155),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Address',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 155, 155),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                       inputFormatters: [
                            
                            FilteringTextInputFormatter.deny(RegExp(r'^ +'))
                          ],
                          keyboardType: TextInputType.streetAddress,
                          controller: _address,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an address';
                            }
                            if (!RegExp( r"^[a-zA-Z0-9_.,!-;][a-zA-Z0-9\s_.,!-;]+$")
                                .hasMatch(value)) {
                              return 'Address is not accepted';
                            }
                            if (value.length > 100) {
                              return ' Address is too long';
                            }
                            return null; // Return null if the validation is successful
                          },
                        ),
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 236, 235, 235),
                        ),
                        
                       
                       
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: SizedBox(
                            width: 300, // <-- match_parent

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 181, 57, 5),
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _showMyDialog();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  chooseAvatar() async {
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
      avt = File(compressedImage!.path);
    });
  }

  takeAvatar() async {
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
      avt = File(compressedImage!.path);
    });
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
      img = File(compressedImage!.path);
    });
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
      img = File(compressedImage!.path);
    });
  }

  Future<void> _showMyDialog() async {
    if (_title.text == '' ||
        _phone.text == '' ||
        _email == '' ||
        _address.text == '' ||
        _username.text == '') {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Edit Profile',
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
                  'Edit Profile',
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Dashboard()));
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

  UploadTask? uploadTask;

  Future<http.Response> getImageUrl() async {
    final metadata = SettableMetadata(contentType: "image/jpeg");

    if (img != null) {
      final r = FirebaseStorage.instance.refFromURL(_image.toString());
       r.delete();
      final imag = File(img!.path);
       final String imagePath = 'images/${DateTime.now()}.jpg';
      final ref =
          FirebaseStorage.instance.ref().child(path.basename(imagePath));
      uploadTask = ref.putFile(imag, metadata);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urldownload = await snapshot.ref.getDownloadURL();
      setState(() {
        _image = urldownload;
      });
    }
    if (avt != null) {
      final ra = FirebaseStorage.instance.refFromURL(_avatar.toString());
      ra.delete();
      final avtar = File(avt!.path);
       final String imagePath = 'images/${DateTime.now()}.jpg';
      final ref =
          FirebaseStorage.instance.ref().child(path.basename(imagePath));
      uploadTask = ref.putFile(avtar, metadata);
      final snapshot = await uploadTask!.whenComplete(() {});
      final urldownload = await snapshot.ref.getDownloadURL();
      setState(() {
        _avatar = urldownload;
      });
    }
     final regex = RegExp(r'\s+');
    print('get imageurl success');
    var dt = new Map();
    dt['id'] = widget.profile.id;
    dt['title'] = _title.text.trim().replaceAll(regex, ' ');
    dt['image'] = _image;
    dt['avatar'] = _avatar;

    dt['phone'] = _phone.text;
    dt['email'] = _email.text;
    dt['address'] = _address.text.trim().replaceAll(regex, ' ');
    dt['username'] = _username.text;
    dt['password'] = password;

    final response =
        await http.post(Uri.parse('$u/api/Supplier/UpdateProfileSupp'),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            body: jsonEncode(dt));
    print('edit profile success');
    return response;
  }
}

validatephone(userInput) {
  if (userInput!.isEmpty) {
    return 'Please enter your phone number';
  }

  // Ensure it is only digits and optional '+' or '00' for the country code.
  if (!RegExp(r'^(\+|00)?[0-9]+$').hasMatch(userInput)) {
    return 'Please enter a valid phone number';
  }

  return null; // Return null when the input is valid
}

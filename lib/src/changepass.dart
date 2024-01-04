import 'dart:convert';
import 'dart:io';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';

import 'package:http/http.dart' as http;

import 'package:coffee/src/sidebar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Changepassword extends StatefulWidget {
  final Supplier profile;
  Changepassword({Key? key, required this.profile}) : super(key: key);
  @override
  State<Changepassword> createState() => _Changepassword();
}

class _Changepassword extends State<Changepassword> {
  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  String? opa;
  TextEditingController _newpassword = TextEditingController();
  TextEditingController _newpasswordconform = TextEditingController();
  TextEditingController _oldpassword = TextEditingController();
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    opa = widget.profile.password;
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Old Password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _oldpassword,
                        obscureText:
                            !_passwordVisible, //This will obscure text dynamically
                        decoration: InputDecoration(
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 380,
                        color: Color.fromARGB(255, 236, 235, 235),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'New Password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _newpassword,
                        obscureText:
                            !_passwordVisible1, //This will obscure text dynamically
                        decoration: InputDecoration(
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible1 = !_passwordVisible1;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 380,
                        color: Color.fromARGB(255, 236, 235, 235),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Confirm',
                            style: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _newpasswordconform,
                        obscureText:
                            !_passwordVisible2, //This will obscure text dynamically
                        decoration: InputDecoration(
                          // Here is key idea
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              _passwordVisible2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible2 = !_passwordVisible2;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 380,
                        color: Color.fromARGB(255, 236, 235, 235),
                      ),
                      Center(
                        child: SizedBox(
                          width: 300, // <-- match_parent

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 181, 57, 5),
                            ),
                            onPressed: () {
                              _showMyDialog();
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
    );
  }

  Future<void> _showMyDialog() async {
    if (_oldpassword.text == opa &&
        _newpassword.text == _newpasswordconform.text &&
        _newpassword.text != '') {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });
      await getImageUrl(widget.profile.id!,_newpassword.text,_oldpassword.text).whenComplete(
        () {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  'Change Password',
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
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Change Password',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Password change failed'),
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
    }
  }

  Future<http.Response> getImageUrl(int idSup , String newpass, String oldpass) async {
   

    final response =
        await http.get(Uri.parse('$u/api/Supplier/SupChangePass?idSUp=$idSup&newPassword=$newpass&oldPassword=$oldpass'),
        );
           

    return response;
  }
}

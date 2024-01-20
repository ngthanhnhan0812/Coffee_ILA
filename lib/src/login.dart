import 'dart:convert';

import 'package:coffee/ip/ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../bundle.dart';

class SupInf {
  int? id;
  String? image;
  String? avatar;
  String? title;
  String? phone;
  String? email;
  String? address;
  String? requestDate;
  String? createDate;
  int? isActive;
  String? username;
  String? password;
  int? idType;
  bool? flagLogin;
  String? saltKey;
  int? idCate;
  String? cateName;

  SupInf(
      {this.id,
      this.image,
      this.avatar,
      this.title,
      this.phone,
      this.email,
      this.address,
      this.requestDate,
      this.createDate,
      this.isActive,
      this.username,
      this.password,
      this.idType,
      this.flagLogin,
      this.saltKey,
      this.idCate,
      this.cateName});

  SupInf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    avatar = json['avatar'];
    title = json['title'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    requestDate = json['requestDate'];
    createDate = json['createDate'];
    isActive = json['isActive'];
    username = json['username'];
    password = json['password'];
    idType = json['idType'];
    flagLogin = json['flagLogin'];
    saltKey = json['saltKey'];
    idCate = json['idCate'];
    cateName = json['cateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['avatar'] = this.avatar;
    data['title'] = this.title;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['requestDate'] = this.requestDate;
    data['createDate'] = this.createDate;
    data['isActive'] = this.isActive;
    data['username'] = this.username;
    data['password'] = this.password;
    data['idType'] = this.idType;
    data['flagLogin'] = this.flagLogin;
    data['saltKey'] = this.saltKey;
    data['idCate'] = this.idCate;
    data['cateName'] = this.cateName;
    return data;
  }
}

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _login();
}

// ignore: camel_case_types
class _login extends State<login> {
  // ignore: prefer_typing_uninitialized_variables
  var _passwordVisible;
  final TextEditingController _account = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  bool flaglogin = false;
  String verifyPassword = "";
  bool cir = false;
  late BuildContext dialogContext;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        return _onWillPop();
      },
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: <Color>[
                Color.fromARGB(255, 255, 121, 63),
                Color.fromARGB(255, 181, 57, 5),
                Color.fromARGB(255, 70, 25, 6),
                Color.fromARGB(172, 71, 30, 12)
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Image(
                            image: AssetImage('assets/images/logov.png'),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Center(
                        child: Text(
                      "L O G I N",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: [
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextFormField(
                                controller: _account,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please enter your user name';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.account_circle_outlined),
                                    hintText: "Enter your sup account",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextFormField(
                                obscureText: !_passwordVisible,
                                controller: _password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'please enter your password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.password),
                                    hintText: "Password",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      icon: Icon(_passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text("Forgot Password?",
                                style: TextStyle(color: Colors.grey))),
                        const SizedBox(height: 20),
                        CupertinoButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              checkLogin();
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromARGB(255, 181, 57, 5)),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
 ) ;}

  Future<void> checkLogin() async {
    SupInf acc = await loginSup();
   await verifyPass();

    if (flaglogin == true && verifyPassword == "true") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userName', acc.username!);
      prefs.setInt('idSup', acc.id!);

      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Login Success',
                style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
              ),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Login success'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
                  },
                ),
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Login Failed',
                style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
              ),
              content: const SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Username or Password is incorrect'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  loginSup() async {
    String acc = _account.text;
    String pass = _password.text;
    SupInf a;
    final response = await http.get(Uri.parse(
        '$u/api/Supplier/supplierLogin?userName=$acc&userPassword=$pass'));
    if (response.statusCode == 200) {
      a = SupInf.fromJson(jsonDecode(response.body));
      flaglogin = a.flagLogin!;
      return SupInf.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

   verifyPass() async {
    SupInf a = await loginSup();
    int idSup = a.id!;
    String pass = _password.text;
    final response = await http.get(Uri.parse(
        '$u/api/Supplier/SupVerifyPass?idSup=$idSup&currentPass=$pass'));
    if (response.statusCode == 200) {
      verifyPassword = response.body;
      return response.body;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
   Future<bool> _onWillPop() async {
   return   false;
  }


}

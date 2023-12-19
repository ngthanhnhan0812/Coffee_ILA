import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bundle.dart';

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

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
                  //     child: Text(
                  //   "Login",
                  //   style: TextStyle(color: Colors.white, fontSize: 40),
                  // )
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image(image: AssetImage('assets/images/logov.png'),fit: BoxFit.cover,)),
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextFormField(
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade200))),
                            child: TextFormField(
                              obscureText: !_passwordVisible,
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
                        onPressed:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));},
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration:  BoxDecoration(
                             borderRadius: BorderRadius.circular(50),
                             color: Color.fromARGB(255, 181, 57, 5)
                            ),
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
    );
  }
}

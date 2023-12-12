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
 
String?opa;
TextEditingController _newpassword = TextEditingController();
TextEditingController _newpasswordconform = TextEditingController();
TextEditingController _oldpassword = TextEditingController();
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  opa = widget.profile.password;
   
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
                      TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller:_oldpassword ,
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
                      TextField(
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: _newpassword,
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
                            'Conform',
                            style: TextStyle(
                                color: Color.fromARGB(255, 155, 155, 155),
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: _newpasswordconform,
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
                                  backgroundColor:
                                      Color.fromARGB(255, 181, 57, 5),
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

if( _oldpassword.text == opa && _newpassword.text ==_newpasswordconform.text && _newpassword.text != ''){
showDialog(context: context, builder: (context){
return Center(child: CircularProgressIndicator(),);
});
  await getImageUrl().whenComplete(() {
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Password',style: TextStyle(color:Color.fromARGB(255, 181, 57, 5) ),),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
             
              Text('Success'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve',style: TextStyle(color: Colors.blue),),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dashboard()));
            },
          ),
        ],
      );
    
    },
  );
 
  },);
 
}else{
 
showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Change Password',style: TextStyle(color:Color.fromARGB(255, 181, 57, 5) ),),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
             
              Text('Password change failed'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel',style: TextStyle(color: Colors.blue),),
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

  Future<http.Response> getImageUrl() async {

    
    var dt = new Map();
    dt['id'] = widget.profile.id;
    dt['title'] = widget.profile.title;
    dt['image'] = widget.profile.image;
    dt['avatar'] = widget.profile.avatar;
    dt['phone'] = widget.profile.phone;
    dt['email'] =widget.profile.email;
    dt['address'] = widget.profile.address;
    dt['username'] = widget.profile.username;
    dt['password'] = _newpassword.text;
   
    final response =
        await http.post(Uri.parse('$u/api/Supplier/UpdateProfileSupp'),
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            },
            body: jsonEncode(dt));
   
    return response;
  
 
  }
}

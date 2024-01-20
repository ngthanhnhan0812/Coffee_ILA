import 'dart:convert';

import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/changepass.dart';
import 'package:coffee/src/editprofile.dart';
import 'package:coffee/src/marketing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee/bundle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Supplier {
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
  int? idCate;
  String? cateName;

  Supplier(
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
      this.idCate,
      this.cateName});

  Supplier.fromJson(Map<String, dynamic> json) {
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
    idCate = json['idCate'];
    cateName = json['cateName'];
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder(
            future: fetchProfileSupplier(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(snapshot.data!.title.toString()),
                      accountEmail: Text(snapshot.data!.email.toString()),
                      currentAccountPicture: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            snapshot.data!.avatar.toString(),
                            fit: BoxFit.cover,
                            width: 90,
                            height: 90,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 181, 57, 5),
                        image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image:
                                NetworkImage(snapshot.data!.image.toString())),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(snapshot.data!.username.toString()),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(snapshot.data!.phone.toString()),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text(snapshot.data!.email.toString()),
                    ),
                    ListTile(
                      leading: Icon(Icons.map),
                      title: Text(snapshot.data!.address.toString()),
                    ),
                    CupertinoButton(
                        child: Row(
                         
                          children: [
                            Icon(Icons.edit,color: Color.fromARGB(255, 181, 57, 5),),
                            SizedBox(width: 10,),
                            Text(
                              'Edit           ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 181, 57, 5)),
                            ),
                            SizedBox(width: 130,),
                            Icon(
                              Icons.arrow_right,
                              color: Color.fromARGB(255, 181, 57, 5),
                              size: 30,
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Editprofile(profile: snapshot.data!)));
                        }),
                   
                    Container(
                      height: 1,
                      width: 200,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    CupertinoButton(
                        child: Row(
                         
                          children: [
                            Icon(Icons.lock,color: Color.fromARGB(255, 181, 57, 5),),
                            SizedBox(width: 10,),
                            Text(
                              'Security',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 181, 57, 5)),
                            ),
                            SizedBox(width: 144,),
                            Icon(
                              Icons.arrow_right,
                              color: Color.fromARGB(255, 181, 57, 5),
                              size: 30,
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Changepassword(profile: snapshot.data!)));
                        }),
                   
                    Container(
                      height: 1,
                      width: 200,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 181, 57, 5)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              // By default show a loading spinner.
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

Future<Supplier> fetchProfileSupplier() async {
 var ids =await getIdSup();
  final response =
      await http.get(Uri.parse('$u/api/Supplier/ProfileSupplier?id=$ids '));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    print(jsonResponse);
    return Supplier.fromJson(jsonResponse[0]);
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<Supplier> fetchTitleSupplier() async {
   var ids =await getIdSup();
  final response =
      await http.get(Uri.parse('$u/api/Supplier/ProfileSupplier?id=$ids '));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    var title = jsonResponse[0]["title"];
  
    return title;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

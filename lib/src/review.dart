import 'dart:convert';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Review extends StatefulWidget {
  const Review({Key? key, required this.idpro}) : super(key: key);
  final Product idpro;

  @override
  State<Review> createState() => _Review();
}

class _Review extends State<Review> {
  bool isPressed1 = false;
  bool isPressed2 = true;
  bool isPressed3= true;
  var group1Value;
  var revieww;
   @override
  void initState() {
   group1Value =5;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
           
            toolbarHeight: 70,
        centerTitle: true,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Text(
              widget.idpro.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
              ),
            
            leading: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Productdetail(pro: widget.idpro)));
                },
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 25,
                )),
            flexibleSpace: Container(),
            
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      
                      
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.thumb_up_alt,color: isPressed1?Colors.grey:Color.fromARGB(255, 181, 57, 5),size: 15,),
                                SizedBox(width: 5,),
                                Text('All reviews',style: TextStyle(color: isPressed1?Colors.grey:Color.fromARGB(255, 181, 57, 5)),)
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(height: 2,width: 100,color:  isPressed1?const Color.fromARGB(255, 255, 255, 255):Color.fromARGB(255, 181, 57, 5),)
                          ],
                        ),
                        onPressed: () {
                          setPress1();
                          
                        }),
                    MaterialButton(
                    
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.filter_alt_rounded,color: isPressed2?Colors.grey:Color.fromARGB(255, 181, 57, 5),size: 15,),
                                Text(
                                  'Filter',
                                 style: TextStyle(color: isPressed2?Colors.grey:Color.fromARGB(255, 181, 57, 5))
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Container(height: 2,width: 100,color:  isPressed2?const Color.fromARGB(255, 255, 255, 255):Color.fromARGB(255, 181, 57, 5),)
                          ],
                        ),
                        onPressed: () {
                          setPress2();
                          showModalBottomSheet(
                            isDismissible: false,
                              context: context,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20))),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter myState) {
                                  return Container(
                                    height: 330,
                                    color:
                                        Color.fromARGB(255, 255, 255, 255),
                                    child: Column(
                                      children: [
                                        RadioListTile(
                                          selected: true,
                                          activeColor: Color.fromARGB(
                                              255, 181, 57, 5),
                                          value: 5,
                                          groupValue: group1Value,
                                          title: Row(children: [
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            FutureBuilder(future: fetchCountFilter(5), builder: (context ,snapshot){
                                              if(snapshot.data != null){
                                                return Text('('+snapshot.data.toString()+')',style: TextStyle(color: Colors.black),);}else{return Container();}
                                              })
                                          ]),
                                          onChanged: (value) => {
                                            myState(() {
                                              group1Value = value;
                                            })
                                          },
                                        ),
                                      
                                        RadioListTile(
                                          activeColor: Color.fromARGB(
                                              255, 181, 57, 5),
                                          value: 4,
                                          groupValue: group1Value,
                                          title: Row(children: [
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                               FutureBuilder(future: fetchCountFilter(4), builder: (context ,snapshot){
                                              if(snapshot.data != null){
                                                return Text('('+snapshot.data.toString()+')');}else{return Container();}
                                              })
                                          ]),
                                          onChanged: (value) => {
                                            myState(() {
                                              group1Value = value;
                                            })
                                          },
                                        ),
                                        RadioListTile(
                                          activeColor: Color.fromARGB(
                                              255, 181, 57, 5),
                                          value: 3,
                                          groupValue: group1Value,
                                          title: Row(children: [
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                              FutureBuilder(future: fetchCountFilter(3), builder: (context ,snapshot){
                                              if(snapshot.data != null){
                                                return Text('('+snapshot.data.toString()+')');}else{return Container();}
                                              })
                                          ]),
                                          onChanged: (value) => {
                                            myState(() {
                                              group1Value = value;
                                            })
                                          },
                                        ),
                                        RadioListTile(
                                          activeColor: Color.fromARGB(
                                              255, 181, 57, 5),
                                          value: 2,
                                          groupValue: group1Value,
                                          title: Row(children: [
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                             FutureBuilder(future: fetchCountFilter(2), builder: (context ,snapshot){
                                              if(snapshot.data != null){
                                                return Text('('+snapshot.data.toString()+')');}else{return Container();}
                                              })
                                          ]),
                                          onChanged: (value) => {
                                            myState(() {
                                              group1Value = value;
                                            })
                                          },
                                        ),
                                        RadioListTile(
                                          activeColor: Color.fromARGB(
                                              255, 181, 57, 5),
                                          value: 1,
                                          groupValue: group1Value,
                                          title: Row(children: [
                                            Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 222, 164, 6),
                                            ),
                                             FutureBuilder(future: fetchCountFilter(1), builder: (context ,snapshot){
                                              if(snapshot.data != null){
                                                return Text('('+snapshot.data.toString()+')');}else{return Container();}
                                              })
                                          ]),
                                          onChanged: (value) => {
                                            myState(() {
                                              group1Value = value;
                                            })
                                          },
                                        ),
                                        Container(
                                          height: 1,
                                          color: const Color.fromARGB(
                                              255, 235, 235, 235),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            OutlinedButton(
                                                style: OutlinedButton
                                                    .styleFrom(
                                                        side: BorderSide(
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    181,
                                                                    57,
                                                                    5))),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Review(
                                                                  idpro: widget
                                                                      .idpro)));
                                                },
                                                child: Text('Reset',
                                                    style: TextStyle(
                                                        color:
                                                            Color.fromARGB(
                                                                255,
                                                                181,
                                                                57,
                                                                5)))),
                                            ElevatedButton(
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255,
                                                          250,
                                                          211,
                                                          211), // Background color
                                                ),
                                                
                                                onPressed: () {
                                                  setState(() {
                                                    revieww = group1Value;
                                                    isPressed3 = false;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Choose',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 181, 57, 5)),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                              });
                       
                        }),
                  ],
                ),
               SizedBox(height: 5,),
               Container(height: 1,width: 380,color: Colors.grey.shade100,),
               SizedBox(height: 5,),
                SizedBox(
                  height: 500,
                  child: FutureBuilder<List<Reviews>>(
                      future: isPressed3
                          ? fetchReviews()
                          : fetchReviewsFilteer(revieww),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  color: Colors.white,
                                  width: 350,
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data![index].nameCus
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text('('),
                                                Icon(Icons.star,
                                                    color: Color.fromARGB(
                                                        255, 222, 164, 6)),
                                                Text(snapshot
                                                        .data![index].review
                                                        .toString() +
                                                    ')')
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            comment(
                                                snapshot.data![index].review),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              
                                                          snapshot
                                                              .data![index]
                                                              .createDate!
                                                              ,
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            Container(
                                              height: 1,
                                              width: 320,
                                              color: Color.fromARGB(
                                                  255, 239, 239, 239),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
             
              ],
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }

  setPress1() {
    if (isPressed1 = true) {
      setState(() {
        isPressed1 = false;
        isPressed2 = true;
        isPressed3 = true;
      });
    } else {
      isPressed1 = false;
      isPressed2 = true;
      isPressed3 = true;
    }
  }

  setPress2() {
    if (isPressed2 = true) {
      setState(() {
        isPressed2 = false;
        isPressed1 = true;
      });
    } else {
      isPressed2 = false;
      isPressed1 = true;
    }
  }

  comment(countrevieww) {
    if (countrevieww == 4 || countrevieww == 5) {
      return Text('Very Good');
    } else {
      if (countrevieww == 3) {
        return Text('Good');
      } else {
        return Text('Bad');
      }
    }
  }

  Future<List<Reviews>> fetchReviews() async {
    final id = widget.idpro.id;
    final response =
        await http.get(Uri.parse('$u/api/Supplier/Review/GetDetailReview?idProduct=$id '));
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((data) => Reviews.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Reviews>> fetchReviewsFilteer(revieww) async {
    final id = widget.idpro.id;
    final response = await http.get(
        Uri.parse('$u/api/Supplier/Review/FilterReview?idProduct=$id&review=$revieww '));
   
    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      print(jsonResponse);
      return jsonResponse.map((data) => Reviews.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  fetchCountFilter(revieww)async{
    final id = widget.idpro.id;
    final response =
        await http.get(Uri.parse('$u/api/Supplier/Review/CountFilter?idProduct=$id&review=$revieww '));
    
    if (response.statusCode == 200) {
     return response.body;
     
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

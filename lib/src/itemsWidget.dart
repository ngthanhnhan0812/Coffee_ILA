import 'dart:convert';
import 'dart:io';

import 'package:coffee/src/editproduct.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:flutter/cupertino.dart';
import 'package:coffee/src/myproduct.dart';

class ItemsWidget1 extends StatefulWidget {
  @override
  State<ItemsWidget1> createState() => _ItemsWidget1();
}

class _ItemsWidget1 extends State<ItemsWidget1> {
  var group1Value;
  bool fil = true;
  @override
  void initState() {
    group1Value = 0;
    fetchCategory();
    fetchProduct(1);
    super.initState();
  }
  @override
  void dispose(){
    
    fetchProduct(1);
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Quantity:',
              style: TextStyle(
                  color: Color.fromARGB(255, 181, 57, 5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future:fil? fetchCountisActive(1):quantityProductFilter(1, group1Value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
              snapshot.data.toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 181, 57, 5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              width: 180,
            ),
            CupertinoButton(
                child: Row(children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 17,
                    color: Colors.grey,
                  ),
                  Text(
                    'Filter',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ]),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: false,
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter myState) {
                          return Container(
                            height: 500,
                            child: Column(
                              children: [
                                Container(
                                  height: 450,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        selected: true,
                                        activeColor:
                                            Color.fromARGB(255, 181, 57, 5),
                                        value: 0,
                                        groupValue: group1Value,
                                        title: Text(
                                          'All',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (value) => {
                                          myState(() {
                                            group1Value = value;
                                          })
                                        },
                                      ),
                                      Container(
                                        height: 390,
                                        child: FutureBuilder(
                                            future: fetchCategory(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return RadioListTile(
                                                        activeColor:
                                                            Color.fromARGB(255,
                                                                181, 57, 5),
                                                        value: snapshot
                                                            .data![index].id,
                                                        groupValue: group1Value,
                                                        title: Text(snapshot
                                                            .data![index].title
                                                            .toString()),
                                                        onChanged: (value) => {
                                                          myState(() {
                                                            group1Value = value;
                                                          })
                                                        },
                                                      );
                                                    });
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 380,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                  child: CupertinoButton(
                                      child: Text(
                                        'Filter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      onPressed: () {
                                        if (group1Value == 0) {
                                          setState(() {
                                            fil = true;
                                          });
                                        } else {
                                          setState(() {
                                            fil = false;
                                          });
                                        }

                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                          );
                        });
                      });
                })
          ],
        ),
        Container(
          height: 483,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future:
                    fil ? fetchProduct(1) : filterCateMobile(1, group1Value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 238, 237, 237),
                        ),
                        ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 380,
                                        height: 137,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 9),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                           color:Color.fromARGB(255, 231, 231, 231),
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                          snapshot.data![index]
                                                              .image,
                                                              
                                                              ),
                                                              
                                                    ),
                                                    
                                                    ),
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(9.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.verified,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  181,
                                                                  57,
                                                                  5)
                                                              .withOpacity(0.5),
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot.data![index]
                                                                      .title.length >
                                                                  20
                                                              ? snapshot
                                                                      .data![
                                                                          index]
                                                                      .title
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snapshot
                                                                  .data![index]
                                                                  .title
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.attach_money,
                                                          color: Colors.black,
                                                          size: 16,
                                                        ),
                                                        Text(snapshot
                                                            .data![index].price
                                                            .toString()),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Icon(
                                                          Icons.outbox,
                                                          size: 16,
                                                          color: Colors.black,
                                                        ),
                                                       FutureBuilder(
                                                            future:
                                                                fetchCountWatchList(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id),
                                                            builder: (context,
                                                                snapshot) {
                                                             if(snapshot.data != null){
                                                return Text(snapshot.data.toString());}else{return Container();}
                                                            }),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Icon(
                                                          Icons.favorite_border,
                                                          size: 16,
                                                        ),
                                                        FutureBuilder(
                                                            future:
                                                                fetchCountWatchList(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id),
                                                            builder: (context,
                                                                snapshot) {
                                                             if(snapshot.data != null){
                                                return Text(snapshot.data.toString());}else{return Container();}
                                                            })
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          child: FutureBuilder(
                                                              future: fetchDataReviews(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            243,
                                                                            181,
                                                                            11),
                                                                      ),
                                                                      Text(snapshot
                                                                          .data!
                                                                          .avgReview!
                                                                          .toStringAsFixed(
                                                                              1)),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                        ),
                                                        SizedBox(
                                                          child: FutureBuilder(
                                                              future: fetchCountReviews(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Text('(' +
                                                                      snapshot
                                                                          .data!
                                                                          .toString() +
                                                                      ')');
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 14,
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          width: 1,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                            icon: Icon(
                                                              Icons.hide_source,
                                                              size: 25,
                                                              color:
                                                                 Color.fromARGB(
                                                                  255,
                                                                  181,
                                                                  57,
                                                                  5),
                                                            ),
                                                            onPressed: () {
                                                              hiddenp(snapshot
                                                                  .data![index]
                                                                  .id);
                                                            }),
                                                       
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          right: -9,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Productdetail(
                                                              pro: snapshot
                                                                      .data![
                                                                  index]),
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 20,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 1,
                                    color:
                                        const Color.fromARGB(255, 205, 204, 204)
                                            .withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  )
                                ],
                              );
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
    );
  }

  Future<void> hiddenp(idpro) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Hidden Product',
              style: TextStyle(color: Color.fromARGB(255, 181, 57, 5)),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure ?'),
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
              TextButton(
                child: const Text(
                  'Approve',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  hideProduct(idpro);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Myproduct(initialPage: 3)));
                },
              ),
            ],
          );
        });
  }
}

class ItemsWidget0 extends StatefulWidget {
  @override
  _ItemsWidget0 createState() => _ItemsWidget0();
}

class _ItemsWidget0 extends State<ItemsWidget0> {
  var group1Value;
  bool fil = true;
  @override
  void initState() {
    group1Value = 0;
    fetchProduct(0);
    super.initState();
  }
@override
  void dispose(){
   
    fetchProduct(0);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Quantity:',
              style: TextStyle(
                  color: Color.fromARGB(255, 181, 57, 5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future:fil? fetchCountisActive(0):quantityProductFilter(0, group1Value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 181, 57, 5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              width: 180,
            ),
            CupertinoButton(
                child: Row(children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 17,
                    color: Colors.grey,
                  ),
                  Text(
                    'Filter',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ]),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: false,
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter myState) {
                          return Container(
                            height: 500,
                            child: Column(
                              children: [
                                Container(
                                  height: 450,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        selected: true,
                                        activeColor:
                                            Color.fromARGB(255, 181, 57, 5),
                                        value: 0,
                                        groupValue: group1Value,
                                        title: Text(
                                          'All',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (value) => {
                                          myState(() {
                                            group1Value = value;
                                          })
                                        },
                                      ),
                                      Container(
                                        height: 390,
                                        child: FutureBuilder(
                                            future: fetchCategory(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return RadioListTile(
                                                        activeColor:
                                                            Color.fromARGB(255,
                                                                181, 57, 5),
                                                        value: snapshot
                                                            .data![index].id,
                                                        groupValue: group1Value,
                                                        title: Text(snapshot
                                                            .data![index].title
                                                            .toString()),
                                                        onChanged: (value) => {
                                                          myState(() {
                                                            group1Value = value;
                                                          })
                                                        },
                                                      );
                                                    });
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 380,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                  child: CupertinoButton(
                                      child: Text(
                                        'Filter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      onPressed: () {
                                        if (group1Value == 0) {
                                          setState(() {
                                            fil = true;
                                          });
                                        } else {
                                          setState(() {
                                            fil = false;
                                          });
                                        }

                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                          );
                        });
                      });
                })
          ],
        ),
        Container(
          height: 483,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future:
                    fil ? fetchProduct(0) : filterCateMobile(0, group1Value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 238, 237, 237),
                        ),
                        ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 380,
                                        height: 137,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 9),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                           color:Color.fromARGB(255, 231, 231, 231),
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                          snapshot.data![index]
                                                              .image),
                                                    )),
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(9.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.verified,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  181,
                                                                  57,
                                                                  5)
                                                              .withOpacity(0.7),
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot.data![index]
                                                                      .title.length >
                                                                  15
                                                              ? snapshot
                                                                      .data![
                                                                          index]
                                                                      .title
                                                                      .substring(
                                                                          0,
                                                                          15) +
                                                                  '...'
                                                              : snapshot
                                                                  .data![index]
                                                                  .title
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        IconButton(
                                                            icon: Icon(
                                                              Icons.edit_note,
                                                              color:
                                                                  Color.fromARGB(
                                                                  255,
                                                                  181,
                                                                  57,
                                                                  5),
                                                              size: 25,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          EditProduct(
                                                                              product: snapshot.data![index])));
                                                            })
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.attach_money,
                                                          color: Colors.black,
                                                          size: 16,
                                                        ),
                                                        Text(snapshot
                                                            .data![index].price
                                                            .toString()),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                      width: 230,
                                                      child: Text(
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        snapshot
                                                                    .data![
                                                                        index]
                                                                    .description
                                                                    .length >
                                                                50
                                                            ? snapshot
                                                                    .data![
                                                                        index]
                                                                    .description
                                                                    .substring(
                                                                        0, 50) +
                                                                '...'
                                                            : snapshot
                                                                .data![index]
                                                                .description,
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              135, 135, 135),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          right: -9,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Productdetail1(
                                                              pro: snapshot
                                                                      .data![
                                                                  index]),
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 20,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 1,
                                    color:
                                        const Color.fromARGB(255, 205, 204, 204)
                                            .withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  )
                                ],
                              );
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class ItemsWidget2 extends StatefulWidget {
  @override
  _ItemsWidget2 createState() => _ItemsWidget2();
}

class _ItemsWidget2 extends State<ItemsWidget2> {
  var group1Value;
  bool fil = true;
  @override
  void initState() {
    group1Value = 0;
    fetchProduct(2);
    super.initState();
  }
@override
  void dispose(){
 
    fetchProduct(2);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Quantity:',
              style: TextStyle(
                  color: Color.fromARGB(255, 181, 57, 5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future:fil? fetchCountisActive(2):quantityProductFilter(2, group1Value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 181, 57, 5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              width: 180,
            ),
            CupertinoButton(
                child: Row(children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 17,
                    color: Colors.grey,
                  ),
                  Text(
                    'Filter',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ]),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: false,
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter myState) {
                          return Container(
                            height: 500,
                            child: Column(
                              children: [
                                Container(
                                  height: 450,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        selected: true,
                                        activeColor:
                                            Color.fromARGB(255, 181, 57, 5),
                                        value: 0,
                                        groupValue: group1Value,
                                        title: Text(
                                          'All',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (value) => {
                                          myState(() {
                                            group1Value = value;
                                          })
                                        },
                                      ),
                                      Container(
                                        height: 390,
                                        child: FutureBuilder(
                                            future: fetchCategory(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return RadioListTile(
                                                        activeColor:
                                                            Color.fromARGB(255,
                                                                181, 57, 5),
                                                        value: snapshot
                                                            .data![index].id,
                                                        groupValue: group1Value,
                                                        title: Text(snapshot
                                                            .data![index].title
                                                            .toString()),
                                                        onChanged: (value) => {
                                                          myState(() {
                                                            group1Value = value;
                                                          })
                                                        },
                                                      );
                                                    });
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 380,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                  child: CupertinoButton(
                                      child: Text(
                                        'Filter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      onPressed: () {
                                        if (group1Value == 0) {
                                          setState(() {
                                            fil = true;
                                          });
                                        } else {
                                          setState(() {
                                            fil = false;
                                          });
                                        }

                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                          );
                        });
                      });
                })
          ],
        ),
        Container(
          height: 483,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future:
                    fil ? fetchProduct(2) : filterCateMobile(2, group1Value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 238, 237, 237),
                        ),
                        ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 380,
                                        height: 137,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 9),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                          color:Color.fromARGB(255, 231, 231, 231),
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                          snapshot.data![index]
                                                              .image),
                                                    )),
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(9.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.verified,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  181,
                                                                  57,
                                                                  5)
                                                              .withOpacity(0.5),
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot.data![index]
                                                                      .title.length >
                                                                  20
                                                              ? snapshot
                                                                      .data![
                                                                          index]
                                                                      .title
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snapshot
                                                                  .data![index]
                                                                  .title
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.attach_money,
                                                          color: Colors.black,
                                                          size: 16,
                                                        ),
                                                        Text(snapshot
                                                            .data![index].price
                                                            .toString()),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 60,
                                                      width: 230,
                                                      child: Text(
                                                        maxLines: 3,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        snapshot
                                                                    .data![
                                                                        index]
                                                                    .description
                                                                    .length >
                                                                70
                                                            ? snapshot
                                                                    .data![
                                                                        index]
                                                                    .description
                                                                    .substring(
                                                                        0, 70) +
                                                                '...'
                                                            : snapshot
                                                                .data![index]
                                                                .description,
                                                        style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              135, 135, 135),
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          right: -9,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Productdetail1(
                                                              pro: snapshot
                                                                      .data![
                                                                  index]),
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 20,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 1,
                                    color:
                                        const Color.fromARGB(255, 205, 204, 204)
                                            .withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  )
                                ],
                              );
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class ItemsWidget3 extends StatefulWidget {
  @override
  State<ItemsWidget3> createState() => _ItemsWidget3();
}

class _ItemsWidget3 extends State<ItemsWidget3> {
  var group1Value;
  bool fil = true;
  @override
  void initState() {
    group1Value = 0;
    setState(() {
       fetchProduct(3);
    });
    super.initState();
  }
@override
  void dispose(){
   
    fetchProduct(3);
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(
              'Quantity:',
              style: TextStyle(
                  color: Color.fromARGB(255, 181, 57, 5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future:fil? fetchCountisActive(3):quantityProductFilter(3, group1Value),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                    style: TextStyle(
                        color: Color.fromARGB(255, 181, 57, 5),
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Container();
                }
              },
            ),
            SizedBox(
              width: 180,
            ),
            CupertinoButton(
                child: Row(children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 17,
                    color: Colors.grey,
                  ),
                  Text(
                    'Filter',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ]),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: false,
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter myState) {
                          return Container(
                            height: 500,
                            child: Column(
                              children: [
                                Container(
                                  height: 450,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        selected: true,
                                        activeColor:
                                            Color.fromARGB(255, 181, 57, 5),
                                        value: 0,
                                        groupValue: group1Value,
                                        title: Text(
                                          'All',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        onChanged: (value) => {
                                          myState(() {
                                            group1Value = value;
                                          })
                                        },
                                      ),
                                      Container(
                                        height: 390,
                                        child: FutureBuilder(
                                            future: fetchCategory(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return RadioListTile(
                                                        activeColor:
                                                            Color.fromARGB(255,
                                                                181, 57, 5),
                                                        value: snapshot
                                                            .data![index].id,
                                                        groupValue: group1Value,
                                                        title: Text(snapshot
                                                            .data![index].title
                                                            .toString()),
                                                        onChanged: (value) => {
                                                          myState(() {
                                                            group1Value = value;
                                                          })
                                                        },
                                                      );
                                                    });
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 380,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                  child: CupertinoButton(
                                      child: Text(
                                        'Filter',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      onPressed: () {
                                        if (group1Value == 0) {
                                          setState(() {
                                            fil = true;
                                          });
                                        } else {
                                          setState(() {
                                            fil = false;
                                          });
                                        }

                                        Navigator.pop(context);
                                      }),
                                )
                              ],
                            ),
                          );
                        });
                      });
                })
          ],
        ),
        Container(
          height: 483,
          child: SingleChildScrollView(
            child: FutureBuilder(
                future:
                    fil ? fetchProduct(3) : filterCateMobile(3, group1Value),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: 1,
                          width: 380,
                          color: Color.fromARGB(255, 238, 237, 237),
                        ),
                        ListView.builder(
                            itemCount: snapshot.data!.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 380,
                                        height: 137,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 9),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                            color:Color.fromARGB(255, 231, 231, 231),
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                          snapshot.data![index]
                                                              .image),
                                                    )),
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(9.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.verified,
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  181,
                                                                  57,
                                                                  5)
                                                              .withOpacity(0.5),
                                                          size: 20,
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          snapshot.data![index]
                                                                      .title.length >
                                                                  20
                                                              ? snapshot
                                                                      .data![
                                                                          index]
                                                                      .title
                                                                      .substring(
                                                                          0,
                                                                          20) +
                                                                  '...'
                                                              : snapshot
                                                                  .data![index]
                                                                  .title
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.attach_money,
                                                          color: Colors.black,
                                                          size: 16,
                                                        ),
                                                        Text(snapshot
                                                            .data![index].price
                                                            .toString()),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Icon(
                                                          Icons.outbox,
                                                          size: 16,
                                                          color: Colors.black,
                                                        ),
                                                        FutureBuilder(
                                                            future:
                                                                fetchCountWatchList(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id),
                                                            builder: (context,
                                                                snapshot) {
                                                             if(snapshot.data != null){
                                                return Text(snapshot.data.toString());}else{return Container();}
                                                            }),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Icon(
                                                          Icons.favorite_border,
                                                          size: 16,
                                                        ),
                                                        FutureBuilder(
                                                            future:
                                                                fetchCountWatchList(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .id),
                                                            builder: (context,
                                                                snapshot) {
                                                              return Text(snapshot
                                                                  .data
                                                                  .toString());
                                                            })
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          child: FutureBuilder(
                                                              future: fetchDataReviews(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            243,
                                                                            181,
                                                                            11),
                                                                      ),
                                                                      Text(snapshot
                                                                          .data!
                                                                          .avgReview!
                                                                          .toStringAsFixed(
                                                                              1)),
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                        ),
                                                        SizedBox(
                                                          child: FutureBuilder(
                                                              future: fetchCountReviews(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .id),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Text('(' +
                                                                      snapshot
                                                                          .data!
                                                                          .toString() +
                                                                      ')');
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          right: -9,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Productdetail(
                                                              pro: snapshot
                                                                      .data![
                                                                  index]),
                                                    ));
                                              },
                                              icon: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 20,
                                              )))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 1,
                                    color:
                                        const Color.fromARGB(255, 205, 204, 204)
                                            .withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  )
                                ],
                              );
                            }),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

Future<List<Product>> fetchProduct(isActi) async {
  final response = await http.get(Uri.parse(
      '$u/api/Supplier/Products/FilterActive?isActive=$isActi&idSupplier=2'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((data) => Product.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<List<Product>> filterCateMobile(isActi, idcate) async {
  final response = await http.get(Uri.parse(
      '$u/api/Supplier/Products/FilterCateMobile?idSupplier=2&idcate=$idcate&isActive=$isActi'));

  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    print(jsonResponse);
    return jsonResponse.map((data) => Product.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

fetchCountReviews(idP) async {
  final response = await http
      .get(Uri.parse('$u/api/Supplier/Review/CountReview?idProduct=$idP '));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

fetchCountWatchList(idP) async {
  final response = await http.get(
      Uri.parse('$u/api/Supplier/Products/CountWatchList?idProduct=$idP '));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Unexpected error occured!');
  }
}
fetchCountSold(idP) async {
  final response = await http.get(
      Uri.parse('$u/api/Supplier/Products//Supplier_SoldProd?idSupplier=2&idProduct=$idP '));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Unexpected error occured!');
  }
}
fetchCountisActive(active) async {
  final response = await http.get(Uri.parse(
      '$u/api/Supplier/Products/CountFilterActive?idSupplier=2&isActive=$active '));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<Reviews> fetchDataReviews(int id) async {
  final response = await http
      .get(Uri.parse('$u/api/Supplier/Review/GetDataReview?idProduct=$id '));
  print(response.body);
  if (response.statusCode == 200) {
    return Reviews.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future<http.Response> hideProduct(int idprod) async {
  var p = new Map();
  p['id'] = idprod;
  p['isActive'] = 3;
  final response = await http.post(
      Uri.parse('$u/api/Supplier/Products/changeStatusProductofSupplier'),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(p));

  return response;
}

quantityProductFilter(isActi, idcate)async{
 final response = await http.get(Uri.parse(
      '$u/api/Supplier/Products/FilterCateMobile?idSupplier=2&idcate=$idcate&isActive=$isActi'));
num a;
  if (response.statusCode == 200) {
    List jsonResponse = await json.decode(response.body);
    a= jsonResponse.length;
    return a;
  } else {
    throw Exception('Unexpected error occured!');
  }
}
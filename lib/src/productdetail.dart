import 'dart:convert';

import 'package:coffee/bundle.dart';
import 'package:coffee/ip/ip.dart';
import 'package:coffee/src/itemsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class Reviews {
  int? idProduct;
  String? nameProd;
  double? avgReview;
  int? id;
  int? review;
  int? countReview;
  String? createDate;
  String? nameCus;
  String? imagePro;

  Reviews(
      {this.idProduct,
      this.nameProd,
      this.avgReview,
      this.imagePro,
      this.id,
      this.review,
      this.countReview,
      this.createDate,
      this.nameCus});

  Reviews.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    nameProd = json['nameProd'];
    avgReview = json['avgReview'];
    id = json['id'];
    review = json['review'];
    countReview = json['countReview'];
    createDate = json['createDate'];
    nameCus = json['nameCus'];
    imagePro = json['image'];
  }
}

class Productdetail extends StatefulWidget {
  final Product pro;
  Productdetail({Key? key, required this.pro}) : super(key: key);

  @override
  State<Productdetail> createState() => _Productdetail();
}

class _Productdetail extends State<Productdetail> {
  bool a = true;
  bool b = false;
  bool c = false;
  bool d = false;
  final data =[1];
  String? i;
  @override
  void initState() {
    super.initState();
    i = widget.pro.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
    leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Myproduct(initialPage: 0,)));
            },
            icon: Icon(Icons.arrow_back_ios)),
            centerTitle: true,
            title: Container(
              height: 40,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
              child: Center(
                  child: Text(
                widget.pro.title,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )),
            ),
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 250.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: [
                SizedBox(
                  width: 380,
                  height: 300,
                  child: Image.network(
                    i.toString(),
                   errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
    
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 90,
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: a ? 40 : 30,
                          height: a ? 40 : 30,
                          decoration: BoxDecoration(
                              border: a
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                seta();
                              }),
                        ),
                        Container(
                          width: b ? 40 : 30,
                          height: b ? 40 : 30,
                          decoration: BoxDecoration(
                              border: b
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image1.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                setb();
                              }),
                        ),
                        Container(
                          width: c ? 40 : 30,
                          height: c ? 40 : 30,
                          decoration: BoxDecoration(
                              border: c
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image2.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                setc();
                              }),
                        ),
                        Container(
                          width: d ? 40 : 30,
                          height: d ? 40 : 30,
                          decoration: BoxDecoration(
                              border: d
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image3.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                setd();
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: data.length ,(_, int index) {
              
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         widget.pro.isActive != 0||widget.pro.isActive !=2? SizedBox(child: Row(children: [
                            Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 241, 171, 50),
                            size: 25,
                          ),
                          FutureBuilder(
                              future: fetchDataReviews(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                      snapshot.data!.avgReview!.toStringAsFixed(1));
                                } else {
                                  return Container();
                                }
                              }),
                           FutureBuilder(
                              future: fetchCountReviews(widget.pro.id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text('('+
                                      snapshot.data.toString()+')');
                                } else {
                                  return Container();
                                }
                              }),
                          ]),)
                          :Container()
                         ,
                         SizedBox(child: Row(children: [
                           Icon(Icons.attach_money),
                          Text(widget.pro.price.toString(),style: TextStyle(fontSize: 20),)
                         ]),)
                        ]),
                  ),
                ),
                 Container(
                  height: 10,
                  color: const Color.fromARGB(255, 245, 245, 245),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                         
                          width: 350,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18,color: Color.fromARGB(255, 181, 57, 5)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ReadMoreText(
                                    widget.pro.description,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText:'   Show more',
                                    trimExpandedText: '   Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                    lessStyle: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                Container(
                  height: 10,
                  color: const Color.fromARGB(255, 245, 245, 245),
                ),
               Row(
                children: [
                  SizedBox(width: 60,height: 60,
                  child: Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/f3ab4ef008ef86bdfb3fcce1403e9fb2.png?alt=media&token=60b13d2b-c47f-48f2-bd11-ff73ad0956e4&_gl=1*uujh7n*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5NjkyNzE1NC42Ni4xLjE2OTY5MjcxNjcuNDcuMC4w'),fit: BoxFit.fill,),
                  ),
                  Text('Reviews',style: TextStyle(color:Color.fromARGB(255, 181, 57, 5),fontSize: 20,fontWeight: FontWeight.bold ),),
                  SizedBox(width: 120,),
                  CupertinoButton(child: Text('See all',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),), onPressed: (){ Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Review(idpro: widget.pro),
                              ));})
                ],
               ),
               SizedBox(
                    height: 200,
                 
                        child: FutureBuilder<List<Reviews>>(
                            future: fetchReviews(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                 physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  itemCount: count(snapshot.data!.length),
                                  itemBuilder: (context, index) {
                                   if(snapshot.data!.length > 0){
                                     return Container(
                                  
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
                                                      snapshot.data![index].nameCus
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
                                                        .toString()),
                                                    Text(')')
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
                                     
                                                              snapshot.data![index]
                                                                  .createDate!
                                                                  ,
                                                  style:
                                                      TextStyle(color: Colors.grey),
                                                ),
                                                
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                 
                                   }else{
                                    return Text('No review');
                                   }
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              // By default show a loading spinner.
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            })),
                  
              ]);
            }),
          ),
        ],
      ),
    );
  }

  seta() {
    if (a == true) {
      setState(() {
        i = widget.pro.image;
        b = false;
        c = false;
        d = false;
      });
    } else {
      setState(() {
        i = widget.pro.image;
        a = true;
        b = false;
        c = false;
        d = false;
      });
    }
  }

  setb() {
    if (b == true) {
      setState(() {
        i = widget.pro.image1;
        b = true;
        a = false;
        c = false;
        d = false;
      });
    } else {
      setState(() {
        i = widget.pro.image1;
        b = true;
        a = false;
        c = false;
        d = false;
      });
    }
  }

  setc() {
    if (c == true) {
      setState(() {
        i = widget.pro.image2;
        b = false;
        a = false;
        d = false;
      });
    } else {
      setState(() {
        i = widget.pro.image2;
        c = true;
        b = false;
        a = false;
        d = false;
      });
    }
  }

  setd() {
    if (d == true) {
      setState(() {
        i = widget.pro.image3;
        b = false;
        c = false;
        a = false;
      });
    } else {
      setState(() {
        i = widget.pro.image3;
        d = true;
        b = false;
        c = false;
        a = false;
      });
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

  count(count) {
    if (count > 2) {
      return 2;
    } else {
      return count;
    }
  }

  Future<List<Reviews>> fetchReviews() async {
    final id = widget.pro.id;
    final response =
        await http.get(Uri.parse('$u/api/Supplier/Review/GetDetailReview?idProduct=$id '));
    print(response.body);
    if (response.statusCode == 200) {
      List jsonResponse = await json.decode(response.body);
      return jsonResponse.map((data) => Reviews.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<Reviews> fetchDataReviews() async {
    final id = widget.pro.id;
    final response =
        await http.get(Uri.parse('$u/api/Supplier/Review/GetDataReview?idProduct=$id '));
    print(response.body);
    if (response.statusCode == 200) {
      return Reviews.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}


class Productdetail1 extends StatefulWidget {
  final Product pro;
  Productdetail1({Key? key, required this.pro}) : super(key: key);

  @override
  State<Productdetail1> createState() => _Productdetail1();
}

class _Productdetail1 extends State<Productdetail1> {
  bool a = true;
  bool b = false;
  bool c = false;
  bool d = false;
  final data =[1];
  String? i;
  @override
  void initState() {
    super.initState();
    i = widget.pro.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Myproduct(initialPage: 1,)));
            },
            icon: Icon(Icons.arrow_back_ios)),
            
              
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 250.0,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
              children: [
                SizedBox(
                  width: 380,
                  height: 300,
                  child: Image.network(
                    i.toString(),
                   errorBuilder: (context, url, error) => Image.network("https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/Untitled%20design.png?alt=media&token=f8691876-f45e-4418-b0c5-f98fb2959265",fit: BoxFit.fitWidth,),
    
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 90,
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: a ? 40 : 30,
                          height: a ? 40 : 30,
                          decoration: BoxDecoration(
                              border: a
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                seta();
                              }),
                        ),
                        Container(
                          width: b ? 40 : 30,
                          height: b ? 40 : 30,
                          decoration: BoxDecoration(
                              border: b
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image1.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                setb();
                              }),
                        ),
                        Container(
                          width: c ? 40 : 30,
                          height: c ? 40 : 30,
                          decoration: BoxDecoration(
                              border: c
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image2.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                setc();
                              }),
                        ),
                        Container(
                          width: d ? 40 : 30,
                          height: d ? 40 : 30,
                          decoration: BoxDecoration(
                              border: d
                                  ? Border.all(color: Colors.white, width: 2)
                                  : Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.pro.image3.toString()))),
                          child: CupertinoButton(
                              child: SizedBox(),
                              onPressed: () {
                                setd();
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: data.length ,(_, int index) {
              
              return Column(children: [
                SizedBox(
                  height: 50,
                  child: Row(children: [
                    SizedBox(width: 10,),
                           Text('Price: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                          Text(widget.pro.price.toString(),style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 181, 57, 5),fontWeight: FontWeight.bold),),
                          Icon(Icons.attach_money,color:Color.fromARGB(255, 181, 57, 5) ,size: 25,),
                          ])),

                 Container(
                  height: 10,
                 
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                         
                          width: 350,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18,color: Color.fromARGB(255, 181, 57, 5)),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ReadMoreText(
                                    widget.pro.description,
                                    trimLines: 8,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText:'   Show more',
                                    trimExpandedText: '   Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                    lessStyle: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                
               
              ]);
            }),
          ),
        ],
      ),
    );
  }

  seta() {
    if (a == true) {
      setState(() {
        i = widget.pro.image;
        b = false;
        c = false;
        d = false;
      });
    } else {
      setState(() {
        i = widget.pro.image;
        a = true;
        b = false;
        c = false;
        d = false;
      });
    }
  }

  setb() {
    if (b == true) {
      setState(() {
        i = widget.pro.image1;
        b = true;
        a = false;
        c = false;
        d = false;
      });
    } else {
      setState(() {
        i = widget.pro.image1;
        b = true;
        a = false;
        c = false;
        d = false;
      });
    }
  }

  setc() {
    if (c == true) {
      setState(() {
        i = widget.pro.image2;
        b = false;
        a = false;
        d = false;
      });
    } else {
      setState(() {
        i = widget.pro.image2;
        c = true;
        b = false;
        a = false;
        d = false;
      });
    }
  }

  setd() {
    if (d == true) {
      setState(() {
        i = widget.pro.image3;
        b = false;
        c = false;
        a = false;
      });
    } else {
      setState(() {
        i = widget.pro.image3;
        d = true;
        b = false;
        c = false;
        a = false;
      });
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

  count(count) {
    if (count > 2) {
      return 2;
    } else {
      return count;
    }
  }

  Future<List<Reviews>> fetchReviews() async {
    final id = widget.pro.id;
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

  Future<Reviews> fetchDataReviews() async {
    final id = widget.pro.id;
    final response =
        await http.get(Uri.parse('$u/api/Supplier/Review/GetDataReview?idProduct=$id '));
    print(response.body);
    if (response.statusCode == 200) {
      return Reviews.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}

import 'package:coffee/bundle.dart';
import 'package:coffee/src/order.dart';
import 'package:coffee/src/orderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class ReviewOfOrder extends StatefulWidget {
  final InvoiceSupplier invoice;

  ReviewOfOrder({Key? key, required this.invoice}) : super(key: key);

  @override
  State<ReviewOfOrder> createState() => _ReviewOfOrder();
}

class _ReviewOfOrder extends State<ReviewOfOrder> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.white,
          toolbarHeight: 70,
          centerTitle: true,
          title: Text(
            "Review Of Order",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Container(
                height: 150,
                width: 380,
                color: Color.fromARGB(255, 244, 244, 244),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.place),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Address:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(23, 0, 0, 0),
                        child: ReadMoreText(
                          widget.invoice.address.toString(),
                          trimLines: 2,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 82, 82, 82)),
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          lessStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Name Customer: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            widget.invoice.nameCus!.length > 20
                                ? widget.invoice.nameCus!.substring(0, 20) +
                                    '...'
                                : widget.invoice.nameCus!.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.phone),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Phone: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.invoice.phone.toString(),
                            style: TextStyle(
                                color: const Color.fromARGB(255, 82, 82, 82)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                child: FutureBuilder<List<Reviews>>(
                    future: reviewOfOrderSup(widget.invoice.id),
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
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          color: Color.fromARGB(
                                              255, 231, 231, 231),
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                              snapshot.data![index].imagePro
                                                  .toString(),
                                            ),
                                          ),
                                        ),
                                        width: 60,
                                        height: 60,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data![index].nameProd
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          RatingBar.builder(
                                            initialRating: double.parse(snapshot
                                                .data![index].review
                                                .toString()),
                                            minRating: 1,
                                            itemSize: 20,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 255, 200, 35),
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data![index].createDate
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 89, 89, 89)),
                                            ),
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
          )),
        ));
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      
      body:  CustomScrollView(
    slivers: <Widget>[
      //2
      SliverAppBar(
        pinned: true,snap: true,floating: true,
        expandedHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(
      
          background: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/z3680978897260_2e5b455b588efbfcbe514af4e5bd430b_a23857035de045e3b4ac8e745f586db0_1024x1024.webp?alt=media&token=20bb3cea-ffc8-4e34-80e3-fae0defebbed&_gl=1*sfqhfs*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5NjY5MjExNy42My4xLjE2OTY2OTIxNDQuMzMuMC4w',
            fit: BoxFit.fill,
          ),
        ),
      ),
      //3
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, int index) {
            return Column(children: [
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.star,
                        color: Color.fromARGB(255, 183, 183, 183),
                        size: 25,
                      ),
                      Text(
                        '4.0',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text('(50+)', style: TextStyle(fontSize: 15)),
                      SizedBox(
                        width: 130,
                      ),
                      CupertinoButton(
                          child: Text(
                            'See all',
                            style: TextStyle(
                                color: Color.fromARGB(255, 181, 57, 5),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          onPressed: () {})
                    ]),
              ),
            ),
          
            Container(
              height: 10,
              color: const Color.fromARGB(255, 245, 245, 245),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/f3ab4ef008ef86bdfb3fcce1403e9fb2.png?alt=media&token=4db834cf-3d3b-431d-82c2-742161c353a1&_gl=1*f5ufux*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5NjY2MTA2OC41OS4xLjE2OTY2NjExNDYuNTMuMC4w",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Cafe",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 190,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Color.fromARGB(255, 146, 146, 146),
                  )
                ],
              ),
            ),
            Container(height: 2, color: Color.fromARGB(255, 245, 245, 245)),
            Container(
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                       childAspectRatio: 7/10
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                       
                        child: Column(
                          
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                              height: 170,
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, bottom: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/ilacoffeeproject.appspot.com/o/z3680978897260_2e5b455b588efbfcbe514af4e5bd430b_a23857035de045e3b4ac8e745f586db0_1024x1024.webp?alt=media&token=20bb3cea-ffc8-4e34-80e3-fae0defebbed&_gl=1*sfqhfs*_ga*MzY4MTI3NTExLjE2OTMwMjA0ODk.*_ga_CW55HF8NVT*MTY5NjY5MjExNy42My4xLjE2OTY2OTIxNDQuMzMuMC4w",
                                    ),
                                  )),
                            ),
                         Row(children: [
                          SizedBox(width: 10,),
                          Text('Milk Tea'),
                         ],),
                         Row(children: [
                          SizedBox(width: 5,),
                          Icon(Icons.attach_money),
                          Text('120')
                         ],)
                          ],
                        ),
                      );
                    })),
          ]);
      
      
         
            }
         
        ),
      ),
    ],
  ),
    );
 
  }
}

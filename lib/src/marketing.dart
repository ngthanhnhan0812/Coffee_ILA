import 'package:coffee/bundle.dart';
import 'package:coffee/src/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Marketing extends StatefulWidget {
  const Marketing({super.key, required List containSelectedBox});

  @override
  State<Marketing> createState() => _Marketing();
}

class _Marketing extends State<Marketing> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Dashboard()));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          "MARKETING",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(11),
            child: Text(
              'Feature',
              style: TextStyle(
                  color: const Color.fromARGB(255, 69, 68, 68)
                                .withOpacity(0.5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 250,
              width: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 202, 200, 200),
                      width: 1,
                      style: BorderStyle.solid),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CupertinoButton(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.confirmation_number_outlined,
                              color: Color.fromARGB(255, 181, 57, 5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'My voucher',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 181, 57, 5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: Color.fromARGB(255, 181, 57, 5),
                            )
                          ],
                        ),
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voucher_home(ind: 0)));}),
                    CupertinoButton(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Up Coming',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_right_sharp,color: Colors.black,)
                          ],
                        ),
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voucher_home(ind: 0)));}),
                        Container(height: 1,width: 300,color: Colors.grey.shade200,),
                         CupertinoButton(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Online',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_right_sharp,color: Colors.black,)
                          ],
                        ),
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voucher_home(ind: 1)));}),
                        Container(height: 1,width: 300,color: Colors.grey.shade200,),
                         CupertinoButton(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Done',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_right_sharp,color: Colors.black,)
                          ],
                        ),
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voucher_home(ind: 2)));}),
                        Container(height: 1,width: 300,color: Colors.grey.shade200,)
                  ],
                ),
              ),
            ),
          )
       , Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 240,
              width: 380,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 202, 200, 200),
                      width: 1,
                      style: BorderStyle.solid),
                  color: const Color.fromARGB(255, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    CupertinoButton(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.business_center,
                              color: Color.fromARGB(255, 181, 57, 5),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Promotions',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 181, 57, 5),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: Color.fromARGB(255, 181, 57, 5),
                            )
                          ],
                        ),
                        onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Promotion(ind: 0)));}),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    CupertinoButton(child: Column(children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        radius: 30,
                        child: const Icon(Icons.access_time,color:Color.fromARGB(255, 181, 57, 5),size: 30 ,),
                      ),
                      const SizedBox(height: 3,),
                       const Text(
                              'Up Coming',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                    ],)
                  , onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Promotion(ind: 0)));}),
                   CupertinoButton(child: Column(children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        radius: 30,
                        child: const Icon(Icons.alarm_on_sharp,color:Color.fromARGB(255, 181, 57, 5),size: 30 ,),
                      ),
                      const SizedBox(height: 3,),
                       const Text(
                              'In progress',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                    ],)
                  , onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Promotion(ind: 1)));}),
                   CupertinoButton(child: Column(children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        radius: 30,
                        child: const Icon(Icons.alarm_off,color:Color.fromARGB(255, 181, 57, 5),size: 30 ,),
                      ),
                      const SizedBox(height: 3,),
                       const Text(
                              'Ended',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                    ],)
                  , onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Promotion(ind: 2)));})
                   ],)
                  ],
                ),
              ),
            ),
          )
        
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Dashboard()));
                },
                child: const Icon(
                  Icons.home,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Myproduct(initialPage: 0)));
                },
                child: const Icon(
                  Icons.view_cozy,
                  color: Colors.grey,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {},
                child: const Icon(
                  Icons.leaderboard,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Marketing(containSelectedBox: [],)));
                },
                child: const Icon(
                  Icons.api_sharp,
                  color: Color.fromARGB(255, 181, 57, 5),
                  size: 25,
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => BlogView(ind: 0,)));
                },
                child: const Icon(
                  Icons.app_registration,
                  color: Colors.grey,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

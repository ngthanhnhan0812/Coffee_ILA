import 'dart:convert';
import 'package:coffee/src/models/invoiceSupplier.dart';
import 'package:http/http.dart' as http;
import 'package:coffee/bundle.dart';
import 'package:coffee/src/blog.dart';
import 'package:flutter/material.dart';
import 'package:coffee/ip/ip.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<InvoiceSupplier> parseRevenue(String responseBody, int idSupplier) {
  final Map<String, dynamic> parsed = json.decode(responseBody);
  return parsed.entries
      .map((entry) => InvoiceSupplier(
          month: int.parse(entry.key),
          sumRevenue: (entry.value as num).toDouble(),
          idSupplier: idSupplier))
      .toList();
}

Future<List<InvoiceSupplier>> fetchRevenueSupplier(int year) async {
  int id = await getIdSup();

  final response = await http.get(Uri.parse(
      '$u/api/Invoice/getSumRevenueByYearsSupplier?idSupplier=$id&Years=$year'));
  // ignore: avoid_print
  print(response.body);
  if (response.statusCode == 200) {
    return parseRevenue(response.body, id);
  } else {
    throw Exception(
        'Unable to fetch Revenue of Supplier from the REST API of revenue.dart!');
  }
}

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  List<InvoiceSupplier> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Dashboard()));
              },
              icon: const Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          centerTitle: true,
          title: const Text(
            "REVENUE",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Dashboard()));
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Revenue()));
                  },
                  child: const Icon(
                    Icons.leaderboard,
                    color: Color.fromARGB(255, 181, 57, 5),
                    size: 25,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Marketing(
                              containSelectedBox: [],
                            )));
                  },
                  child: const Icon(
                    Icons.api_sharp,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlogView(ind: 0)));
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
        body: Column(children: [
          FutureBuilder(
            future: fetchRevenueSupplier(2023),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                data = snapshot.data as List<InvoiceSupplier>;
                return Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            isDismissible: false,
                            context: context,
                            builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Select year:",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text('Revenue in' ':' ' ${data[9].sumRevenue}')),
                    const SizedBox(height: 50),
                    SfCartesianChart(
                        primaryXAxis: const CategoryAxis(),
                        title:
                            const ChartTitle(text: 'A yearly sales analysis'),
                        legend: const Legend(isVisible: true),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<InvoiceSupplier, int>>[
                          LineSeries<InvoiceSupplier, int>(
                              dataSource: data,
                              xValueMapper: (InvoiceSupplier data, _) =>
                                  data.month,
                              yValueMapper: (InvoiceSupplier data, _) =>
                                  data.sumRevenue,
                              name: 'Sales',
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true))
                        ]),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ]));
  }
}

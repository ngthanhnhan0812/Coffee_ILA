import 'package:coffee/bundle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchProduct extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  FetchProduct productList = FetchProduct();

  @override
  Widget buildResults(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.only(left: 8),
          child: FutureBuilder<List<Product>>(
              future: productList.fetch_prodProduct(query: query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int index) {
                            return Row(children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Image.network(
                                        snapshot.data![index].image),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                ],
                              ),
                              const VerticalDivider(width: 10),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        snapshot.data![index].title.length > 44
                                            ? '${snapshot.data![index].title.substring(0, 28)}...'
                                            : snapshot.data![index].title,
                                        style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        ' ',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index].price.toString(),
                                        style: GoogleFonts.openSans(),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]);
                          })
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.only(left: 8),
          child: FutureBuilder<List<Product>>(
              future: productList.fetch_prodProduct(query: query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int index) {
                            return Row(children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Image.network(
                                        snapshot.data![index].image),
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                ],
                              ),
                              const VerticalDivider(width: 10),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        snapshot.data![index].title.length > 44
                                            ? '${snapshot.data![index].title.substring(0, 28)}...'
                                            : snapshot.data![index].title,
                                        style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        ' ',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data![index].price.toString(),
                                        style: GoogleFonts.openSans(),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ]);
                          })
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const Center(child: Text('No result'));
              })),
    );
  }
}

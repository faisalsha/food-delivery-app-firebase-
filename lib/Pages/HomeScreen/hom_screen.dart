import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/DetailScreen/detail_screen.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/app_drawer.dart';
import 'package:fooddelivery/Widgets/grid_view_widget.dart';
import 'package:fooddelivery/Widgets/products.dart';
import 'package:fooddelivery/models/user_model.dart';
import 'package:shimmer/shimmer.dart';

late UserModel userModel;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = '';
  var result;

  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element['productName'].toLowerCase().contains(query) ||
          element['productName'].toUpperCase().contains(query) ||
          element['productName'].toLowerCase().contains(query) &&
              element['productName'].toUpperCase().contains(query);
    }).toList();
    return result;
  }

  Future getUserDataFromFirebase() async {
    //reach out to users table search and return us current user details
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        userModel = UserModel.fromDocument(documentSnapshot);
      } else {
        print("document does not exists");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserDataFromFirebase();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => GestureDetector(
            child: Icon(
              Icons.format_align_left_rounded,
              color: Colors.black,
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              // shape:CircularProgressIndicator()
              shadowColor: Colors.grey[300],
              elevation: 10.0,
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: "Search Products",
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          query == ''
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("categories")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                        if (streamsnapshot.hasData) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  streamsnapshot.data!.docs.length, (index) {
                                return Categories(
                                  categoryName: streamsnapshot.data!.docs[index]
                                      ['categoryName'],
                                  image: streamsnapshot.data!.docs[index]
                                      ['categoryImage'],
                                  onTap: () {
                                    RoutingPage.push(
                                        context: context,
                                        page: GridViewWidget(
                                          id: streamsnapshot
                                              .data!.docs[index].id,
                                          collection: "categories",
                                          subCollection: streamsnapshot.data!
                                              .docs[index]['categoryName'],
                                        ));
                                  },
                                );
                              }),
                            ),
                          );
                        } else if (!streamsnapshot.hasData) {
                          return Text("No data found");
                        } else if (streamsnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.purple.shade300,
                              highlightColor: Colors.purple,
                              child: Text(
                                'Shimmer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          // return SizedBox(
                          //   width: 200.0,
                          //   height: 100.0,
                          //   child: Shimmer.fromColors(
                          //     baseColor: Colors.purple.shade300,
                          //     highlightColor: Colors.purple,
                          //     child: Text(
                          //       'Shimmer',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //         fontSize: 40.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // );

                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Products",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //products section below
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                        if (streamsnapshot.hasData) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  streamsnapshot.data!.docs.length, (index) {
                                var data = streamsnapshot.data!.docs[index];
                                return Products(
                                  onTap: () {
                                    RoutingPage.push(
                                        context: context,
                                        page: DetailScreen(
                                          productCategory:
                                              data['productCategory'],
                                          productId: data['productId'],
                                          productName: data['productName'],
                                          productPrice: data['productPrice'],
                                          productImage: data['productImage'],
                                          productOldPrice:
                                              data['productOldPrice'],
                                          productRate: data['productRate'],
                                        ));
                                  },
                                  productOldPrice: data['productOldPrice'],
                                  productRate: data['productRate'],
                                  productId: data['productId'],
                                  productImage: data['productImage'],
                                  productName: data['productName'],
                                  productPrice: data['productPrice'],
                                  productCategory: data['productCategory'],
                                  // price: data['productPrice'],
                                  // productImage: data['productImage'],
                                  // productName: data['productName']
                                );
                                // return Categories(
                                //   categoryName: streamsnapshot.data!.docs[index]
                                //       ['categoryName'],
                                //   image: streamsnapshot.data!.docs[index]
                                //       ['categoryImage'],
                                //   onTap: () {
                                //     RoutingPage.push(
                                //         context: context,
                                //         page: GridViewWidget(
                                //           id: streamsnapshot.data!.docs[index].id,
                                //           collection: streamsnapshot.data!.docs[index]
                                //               ['categoryName'],
                                //         ));
                              }),
                            ),
                          );
                        } else if (!streamsnapshot.hasData) {
                          return Text("No data found");
                        } else if (streamsnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.purple.shade300,
                              highlightColor: Colors.purple,
                              child: Text(
                                'Shimmer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          // return SizedBox(
                          //   width: 200.0,
                          //   height: 100.0,
                          //   child: Shimmer.fromColors(
                          //     baseColor: Colors.purple.shade300,
                          //     highlightColor: Colors.purple,
                          //     child: Text(
                          //       'Shimmer',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //         fontSize: 40.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // );

                          return CircularProgressIndicator();
                        }
                      },
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Best Sell",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Best sell below
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("products")
                          .where("productRate", isGreaterThan: 4)
                          .orderBy("productRate")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                        if (streamsnapshot.hasData) {
                          return SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  streamsnapshot.data!.docs.length, (index) {
                                var data = streamsnapshot.data!.docs[index];
                                return Products(
                                  onTap: () {
                                    RoutingPage.push(
                                        context: context,
                                        page: DetailScreen(
                                          productCategory:
                                              data['productCategory'],
                                          productId: data['productId'],
                                          productName: data['productName'],
                                          productPrice: data['productPrice'],
                                          productImage: data['productImage'],
                                          productOldPrice:
                                              data['productOldPrice'],
                                          productRate: data['productRate'],
                                        ));
                                  },
                                  productOldPrice: data['productOldPrice'],
                                  productRate: data['productRate'],
                                  productId: data['productId'],
                                  productImage: data['productImage'],
                                  productName: data['productName'],
                                  productPrice: data['productPrice'],
                                  productCategory: data['productCategory'],
                                  // price: data['productPrice'],
                                  // productImage: data['productImage'],
                                  // productName: data['productName']
                                );
                                // return Categories(
                                //   categoryName: streamsnapshot.data!.docs[index]
                                //       ['categoryName'],
                                //   image: streamsnapshot.data!.docs[index]
                                //       ['categoryImage'],
                                //   onTap: () {
                                //     RoutingPage.push(
                                //         context: context,
                                //         page: GridViewWidget(
                                //           id: streamsnapshot.data!.docs[index].id,
                                //           collection: streamsnapshot.data!.docs[index]
                                //               ['categoryName'],
                                //         ));
                              }),
                            ),
                          );
                        } else if (!streamsnapshot.hasData) {
                          return Text("No data found");
                        } else if (streamsnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Shimmer.fromColors(
                              baseColor: Colors.purple.shade300,
                              highlightColor: Colors.purple,
                              child: Text(
                                'Shimmer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          // return SizedBox(
                          //   width: 200.0,
                          //   height: 100.0,
                          //   child: Shimmer.fromColors(
                          //     baseColor: Colors.purple.shade300,
                          //     highlightColor: Colors.purple,
                          //     child: Text(
                          //       'Shimmer',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(
                          //         fontSize: 40.0,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //   ),
                          // );

                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    )
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //       // children: [Products(), Products()],
                    //       ),
                    // ),
                  ],
                )
              :
              //show search results
              Container(
                  height: 500,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                      if (streamsnapshot.hasData) {
                        var vardata =
                            searchFunction(query, streamsnapshot.data!.docs);
                        return GridView.builder(
                            itemCount: result.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.62),
                            itemBuilder: (c, index) {
                              var data = vardata[index];

                              return Products(
                                onTap: () {
                                  RoutingPage.push(
                                      context: context,
                                      page: DetailScreen(
                                        productCategory:
                                            data['productCategory'],
                                        productId: data['productId'],
                                        productName: data['productName'],
                                        productPrice: data['productPrice'],
                                        productImage: data['productImage'],
                                        productOldPrice:
                                            data['productOldPrice'],
                                        productRate: data['productRate'],
                                      ));
                                },
                                productOldPrice: data['productOldPrice'],
                                productRate: data['productRate'],
                                productId: data['productId'],
                                productImage: data['productImage'],
                                productName: data['productName'],
                                productPrice: data['productPrice'],
                                productCategory: data['productCategory'],
                                // price: data['productPrice'],
                                // productImage: data['productImage'],
                                // productName: data['productName']
                              );
                            });

                        // return SingleChildScrollView(
                        //   physics: BouncingScrollPhysics(),
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: List.generate(result.length, (index) {
                        //       // var data = streamsnapshot.data!.docs[index];
                        //       var data = vardata[index];
                        //       return Products(
                        //         onTap: () {
                        //           RoutingPage.push(
                        //               context: context,
                        //               page: DetailScreen(
                        //                 productCategory: data['productCategory'],
                        //                 productId: data['productId'],
                        //                 productName: data['productName'],
                        //                 productPrice: data['productPrice'],
                        //                 productImage: data['productImage'],
                        //                 productOldPrice: data['productOldPrice'],
                        //                 productRate: data['productRate'],
                        //               ));
                        //         },
                        //         productOldPrice: data['productOldPrice'],
                        //         productRate: data['productRate'],
                        //         productId: data['productId'],
                        //         productImage: data['productImage'],
                        //         productName: data['productName'],
                        //         productPrice: data['productPrice'],
                        //         productCategory: data['productCategory'],
                        //         // price: data['productPrice'],
                        //         // productImage: data['productImage'],
                        //         // productName: data['productName']
                        //       );
                        //       // return Categories(
                        //       //   categoryName: streamsnapshot.data!.docs[index]
                        //       //       ['categoryName'],
                        //       //   image: streamsnapshot.data!.docs[index]
                        //       //       ['categoryImage'],
                        //       //   onTap: () {
                        //       //     RoutingPage.push(
                        //       //         context: context,
                        //       //         page: GridViewWidget(
                        //       //           id: streamsnapshot.data!.docs[index].id,
                        //       //           collection: streamsnapshot.data!.docs[index]
                        //       //               ['categoryName'],
                        //       //         ));
                        //     }),
                        //   ),
                        // );
                      } else if (!streamsnapshot.hasData) {
                        return Text("No data found");
                      } else if (streamsnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox(
                          width: 200.0,
                          height: 100.0,
                          child: Shimmer.fromColors(
                            baseColor: Colors.purple.shade300,
                            highlightColor: Colors.purple,
                            child: Text(
                              'Shimmer',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // return SizedBox(
                        //   width: 200.0,
                        //   height: 100.0,
                        //   child: Shimmer.fromColors(
                        //     baseColor: Colors.purple.shade300,
                        //     highlightColor: Colors.purple,
                        //     child: Text(
                        //       'Shimmer',
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         fontSize: 40.0,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // );

                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  final String image;
  final String categoryName;
  final void Function()? onTap;

  const Categories(
      {Key? key,
      required this.categoryName,
      required this.image,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        alignment: Alignment.center,
        height: 130,
        width: 220,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          // color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          categoryName.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/DetailScreen/detail_screen.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/products.dart';

class GridViewWidget extends StatelessWidget {
  final String? id;
  final String collection;
  final String subCollection;

  const GridViewWidget(
      {Key? key,
      required this.subCollection,
      required this.id,
      required this.collection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    print(collection);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          subCollection,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              RoutingPage.pop(context: context);
            },
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Material(
          //     // shape:CircularProgressIndicator()
          //     shadowColor: Colors.grey[300],
          //     elevation: 10.0,
          //     child: TextFormField(
          //       decoration: InputDecoration(
          //           fillColor: Colors.white,
          //           filled: true,
          //           prefixIcon: Icon(
          //             Icons.search,
          //             color: Colors.black,
          //           ),
          //           hintText: "Search Products",
          //           border: OutlineInputBorder(borderSide: BorderSide.none)),
          //     ),
          //   ),
          // ),
          //alternative if we want to use future builder use .get() at the end refer below
          // future:FirebaseFirestore.instance
          // .collection(collection)
          // .doc(id)
          // .collection(subCollection)
          // .get(),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(collection)
                  .doc(id)
                  .collection(subCollection)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: snapshot.data!.docs.isEmpty
                        ? Center(child: Text("No Items"))
                        : GridView.builder(
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.63,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 20),
                            itemBuilder: (context, index) {
                              var data = snapshot.data!.docs[index];
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
                                // productImage: snapshot.data!.docs[index]
                                //     ['productImage'],
                                // price: snapshot.data!.docs[index]['productPrice'],
                                // productName: snapshot.data!.docs[index]
                                //     ['productName'],
                              );
                            }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
        ],
      ),
    );
  }
}

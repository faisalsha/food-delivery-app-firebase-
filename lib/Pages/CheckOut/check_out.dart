import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/cart_item.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';
import 'package:shimmer/shimmer.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MyButton(
            onpressed: () {
              RoutingPage.push(context: context, page: CheckOutScreen());
            },
            text: "Proceed"),
      ),
      appBar: AppBar(
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
        title: Text(
          'Checkout',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("cart")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("userCart")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
                if (streamsnapshot.hasData) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: streamsnapshot.data!.docs.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.89,
                            child: Center(child: Text("No Items Found")))
                        : Column(
                            children: List.generate(
                                streamsnapshot.data!.docs.length, (index) {
                              var data = streamsnapshot.data!.docs[index];
                              return CartItem(
                                productId: data['productId'],
                                productImage: data['productImage'],
                                productName: data['productName'],
                                productPrice: data['productPrice'],
                                productQunatity: data['productQuantity'],
                                productCategory: data['productCategory'],
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
          ),
          Expanded(
              child: Column(
            children: [
              ListTile(
                leading: Text("SubTotal"),
                trailing: Text("Rs 250"),
              ),
              ListTile(
                leading: Text("Discount"),
                trailing: Text("Rs 50"),
              ),
              ListTile(
                leading: Text("Shipping"),
                trailing: Text("Rs 20"),
              ),
              Divider(
                thickness: 2,
              ),
              ListTile(
                leading: Text(
                  "Grand Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                trailing: Text(
                  "Rs 220",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

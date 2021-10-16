import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/cart_item.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: MyButton(onpressed: () {}, text: "checkout"),
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
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
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
              child: Column(
                children:
                    List.generate(streamsnapshot.data!.docs.length, (index) {
                  var data = streamsnapshot.data!.docs[index];
                  return CartItem(
                    productImage: data['productImage'],
                    productName: data['productName'],
                    productPrice: data['productPrice'],
                    productQunatity: data['productQuantity'],
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
    );
  }
}

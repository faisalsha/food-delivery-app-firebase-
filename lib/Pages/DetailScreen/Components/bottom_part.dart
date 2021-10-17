import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/CartPage/cart_page.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class BottomPartForDetailScreen extends StatelessWidget {
  final double productOldPrice;
  final double productPrice;
  final String productName;
  final double productRate;
  final String productId;
  final String productImage;
  final String productCategory;

  const BottomPartForDetailScreen(
      {Key? key,
      required this.productPrice,
      required this.productOldPrice,
      required this.productName,
      required this.productRate,
      required this.productId,
      required this.productImage,
      required this.productCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            productName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            children: [
              Text(
                productOldPrice.toString(),
                style: TextStyle(
                    fontSize: 18, decoration: TextDecoration.lineThrough),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                productPrice.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      productRate.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Reviews",
                    style: TextStyle(color: Colors.teal, fontSize: 20),
                  )
                ],
              ),
              const Divider(
                thickness: 2,
              ),
              Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "This is a great product with unique featured ...dbskjfbdkbdjkbdls",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              )
            ],
          ),
          MyButton(
            onpressed: () {
              FirebaseFirestore.instance
                  .collection("cart")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("userCart")
                  .doc(productId)
                  .set({
                'productId': productId,
                'productImage': productImage,
                'productName': productName,
                'productPrice': productPrice,
                'productOldPrice': productOldPrice,
                'productRate': productRate,
                'productQuantity': 1,
                'productCategory': productCategory
              });
              RoutingPage.push(context: context, page: CartPage());
            },
            text: "Add to Cart",
          )
        ],
      ),
    );
  }
}

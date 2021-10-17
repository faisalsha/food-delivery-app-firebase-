import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Provider/cart_provider.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/cart_item.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty
          ? Text("")
          : Padding(
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
            child: Column(
              children: List.generate(
                cartProvider.getCartList.length,
                (index) {
                  var data = cartProvider.cartList[index];
                  return CartItem(
                    productId: data.productId,
                    productImage: data.productImage,
                    productName: data.productName,
                    productPrice: data.productPrice,
                    productQunatity: data.productQunatity,
                    productCategory: data.productCategory,
                  );
                },
              ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/CheckOut/check_out.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class CartItem extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final int productQunatity;
  final String productCategory;
  final String productId;
  CartItem(
      {Key? key,
      required this.productImage,
      required this.productPrice,
      required this.productName,
      required this.productQunatity,
      required this.productCategory,
      required this.productId})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;
  void updatePrice() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .update({"productQuantity": quantity});
  }

  void deleteItem() {
    FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(widget.productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    var finalPrice = widget.productPrice * widget.productQunatity;
    print(widget.productId.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.productImage),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    height: 200,
                    width: double.infinity,
                    // color: Colors.orangeAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.productName,
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.productCategory,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Rs " + finalPrice.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IncremenetAndDecrement(
                              icon: Icons.add,
                              onPressed: () {
                                quantity++;
                                updatePrice();
                              },
                            ),
                            SizedBox(
                              width: 13,
                            ),
                            Text(widget.productQunatity.toString()),
                            SizedBox(
                              width: 13,
                            ),
                            IncremenetAndDecrement(
                              icon: Icons.remove,
                              onPressed: () {
                                if (quantity > 1) {
                                  quantity--;
                                  updatePrice();
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: -10,
              right: -10,
              child: IconButton(
                onPressed: () {
                  deleteItem();
                },
                icon: Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncremenetAndDecrement extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  const IncremenetAndDecrement(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey.shade300,
      radius: 16,
      child: Center(
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 16,
              ))),
    );
  }
}

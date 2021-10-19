import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddelivery/models/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];
  CartModel? cartModel;

  Future getCartData() async {
    List<CartModel> newCartList = [];
    //acts like a stream
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .get();

    querySnapshot.docs.forEach((element) {
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    });
    cartList = newCartList;
    notifyListeners();
  }

  double subTotal() {
    double subTotal = 0.0;
    cartList.forEach((element) {
      subTotal = subTotal + element.productPrice * element.productQunatity;
    });
    return subTotal;
  }

  List<CartModel> get getCartList {
    return cartList;
  }
}

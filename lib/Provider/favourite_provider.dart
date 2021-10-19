import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class FavouriteProvider extends ChangeNotifier {
  favourite(
      {required productId,
      required productImage,
      required productName,
      required productPrice,
      required productRate,
      required productOldPrice,
      required productCategory,
      required productFavourite}) {
    FirebaseFirestore.instance
        .collection("favourite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavourite")
        .doc(productId)
        .set({
      "productId": productId,
      "productImage": productImage,
      "productName": productName,
      "productPrice": productPrice,
      "productRate": productRate,
      "productOldPrice": productOldPrice,
      "productFavourite": productFavourite,
      "productCategory": productCategory,
    });
  }

  removeFavourite({required productId}) {
    FirebaseFirestore.instance
        .collection("favourite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavourite")
        .doc(productId)
        .delete();
    notifyListeners();
  }
}

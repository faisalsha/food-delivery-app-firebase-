import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CartModel {
  final String productId;
  final String productImage;
  final String productName;
  final double productPrice;
  final int productQunatity;
  final String productCategory;

  CartModel(
      {required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productQunatity,
      required this.productCategory});

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      productId: doc['productId'],
      productImage: doc['productImage'],
      productName: doc['productName'],
      productPrice: doc['productPrice'],
      productQunatity: doc['productQuantity'],
      productCategory: doc['productCategory'],
    );
  }
}

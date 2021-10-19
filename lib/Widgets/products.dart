import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Provider/favourite_provider.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  final productId;
  final productImage;
  final productName;
  final productPrice;
  final productOldPrice;
  final productRate;

  final productCategory;
  // final productFavourite;

  // final String productName;
  // final double price;
  // final String productImage;
  final void Function()? onTap;
  const Products(
      {Key? key,
      required this.productRate,
      required this.productOldPrice,
      required this.productId,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.productCategory,
      // required this.productFavourite,
      required this.onTap})
      : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    FavouriteProvider favouriteProvider =
        Provider.of<FavouriteProvider>(context);
    FirebaseFirestore.instance
        .collection("favourite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userFavourite")
        .doc(widget.productId)
        .get()
        .then((value) {
      if (this.mounted) {
        if (value.exists) {
          setState(() {
            isFavourite = value.get('productFavourite');
          });
        }
      }
    });

    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: Card(
          elevation: 10.0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            // margin: EdgeInsets.only(top: 10, left: 10, right: 6, bottom: 100),
            // height: 200,
            width: 190,
            // // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  height: 230,
                  // width: 200,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    image: DecorationImage(
                        image: NetworkImage(
                          widget.productImage,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFavourite = !isFavourite;
                          if (isFavourite == true) {
                            //add item to db
                            favouriteProvider.favourite(
                                productRate: widget.productRate,
                                productOldPrice: widget.productOldPrice,
                                productId: widget.productId,
                                productImage: widget.productImage,
                                productName: widget.productName,
                                productPrice: widget.productPrice,
                                productCategory: widget.productCategory,
                                productFavourite: true);
                          } else if (isFavourite == false) {
                            //delete item from favourite
                            favouriteProvider.removeFavourite(
                                productId: widget.productId);
                          }
                        });
                      },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.deepOrange,
                        size: 30,
                      )),
                  // child:
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Rs  " + widget.productPrice.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget.productName,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

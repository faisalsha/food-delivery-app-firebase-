import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final String productName;
  final double price;
  final String productImage;
  final void Function()? onTap;
  const Products(
      {Key? key,
      required this.price,
      required this.productImage,
      required this.productName,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  height: 230,
                  // width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          productImage,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Rs  " + price.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  productName,
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

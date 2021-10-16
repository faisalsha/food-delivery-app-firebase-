import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/DetailScreen/Components/bottom_part.dart';
import 'package:fooddelivery/Pages/DetailScreen/Components/top_part.dart';
import 'package:fooddelivery/Routes/push.dart';

class DetailScreen extends StatefulWidget {
  final String productImage;
  final double productOldPrice;
  final double productPrice;
  final String productName;
  final double productRate;
  final String productId;

  DetailScreen(
      {Key? key,
      required this.productImage,
      required this.productOldPrice,
      required this.productPrice,
      required this.productName,
      required this.productRate,
      required this.productId})
      : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.productId);
    return Scaffold(
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
          widget.productName,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopPartForDetailScreen(
              productImage: widget.productImage,
            ),
            BottomPartForDetailScreen(
              productId: widget.productId,
              productImage: widget.productImage,
              productName: widget.productName,
              productOldPrice: widget.productOldPrice,
              productPrice: widget.productPrice,
              productRate: widget.productRate,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TopPartForDetailScreen extends StatelessWidget {
  final String productImage;
  const TopPartForDetailScreen({Key? key, required this.productImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
            image: DecorationImage(
                image: NetworkImage(productImage), fit: BoxFit.cover)),
      ),
    );
  }
}

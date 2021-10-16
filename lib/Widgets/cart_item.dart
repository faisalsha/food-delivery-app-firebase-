import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String productImage;
  final String productName;
  final double productPrice;
  final int productQunatity;
  CartItem(
      {Key? key,
      required this.productImage,
      required this.productPrice,
      required this.productName,
      required this.productQunatity})
      : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
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
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Food",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.productPrice.toString(),
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IncremenetAndDecrement(
                        icon: Icons.add,
                        onPressed: () {},
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
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ))
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

import 'package:flutter/material.dart';

class TopPart extends StatelessWidget {
  const TopPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              "assets/images/food.jpg",
              scale: 3,
            ),
            Text(
              "Login",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}

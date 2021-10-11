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
            Text(
              "Taste the Goodness",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              "Explore Us",
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ],
    );
  }
}

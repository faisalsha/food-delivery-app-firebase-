import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/Welcome/Components/bottom_part.dart';
import 'package:fooddelivery/Pages/Welcome/Components/center_part.dart';

import 'Components/top_part.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //top-part
              TopPart(),
              //center-part
              CenterPart(),
              //bottom-part
              BottomPart()
            ],
          ),
        ),
      ),
    );
  }
}

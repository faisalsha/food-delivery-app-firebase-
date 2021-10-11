import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/bottom_part.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/center_part.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/top_part.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [TopPart(), CenterPartForLogin(), BottomPartForLogin()],
        ),
      ),
    );
  }
}

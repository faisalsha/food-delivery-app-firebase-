import 'package:flutter/material.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class BottomPartForLogin extends StatelessWidget {
  const BottomPartForLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onpressed: () {},
          text: "Log in",
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "SIGNUP",
              style: TextStyle(fontSize: 16),
            )
          ],
        )
      ],
    );
  }
}

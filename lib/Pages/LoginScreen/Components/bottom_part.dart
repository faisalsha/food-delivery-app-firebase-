import 'package:flutter/material.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class BottomPartForLogin extends StatelessWidget {
  final void Function()? onpressed;

  BottomPartForLogin({Key? key, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onpressed: onpressed,
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

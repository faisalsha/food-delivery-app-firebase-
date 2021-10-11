import 'package:flutter/material.dart';

class CenterPartForLogin extends StatelessWidget {
  const CenterPartForLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: "Enter Email"),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: "Enter Password",
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility_off),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CenterPartForLogin extends StatelessWidget {
  final TextEditingController? email;
  final TextEditingController? password;
  final void Function()? onPressed;
  final Widget icon;
  final bool obscuretext;

  const CenterPartForLogin(
      {Key? key,
      this.email,
      this.password,
      this.onPressed,
      required this.icon,
      required this.obscuretext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: email,
          decoration: InputDecoration(hintText: "Enter Email"),
        ),
        TextFormField(
          obscureText: obscuretext,
          controller: password,
          decoration: InputDecoration(
            hintText: "Enter Password",
            suffixIcon: IconButton(
              onPressed: onPressed,
              icon: icon,
            ),
          ),
        ),
      ],
    );
  }
}

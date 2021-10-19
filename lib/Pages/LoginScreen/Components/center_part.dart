import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/ForgotPassword/forgot_password.dart';
import 'package:fooddelivery/Routes/push.dart';

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
            counter: GestureDetector(
              onTap: () {
                RoutingPage.push(
                    context: context, page: ForgotPasswordScreen());
              },
              child: Text(
                "Forgot Password ?",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
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

import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/SignUp/signup.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class BottomPartForLogin extends StatelessWidget {
  final void Function()? onpressed;
  final bool isLoading;

  BottomPartForLogin({Key? key, this.onpressed, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MyButton(
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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUp();
                }));
              },
              child: Text(
                "SIGNUP",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        )
      ],
    );
  }
}

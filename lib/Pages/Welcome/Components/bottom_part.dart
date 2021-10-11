import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/SignUp/signup.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(
          onpressed: () {},
          text: "Login",
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            print("pressed");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SignUp();
            }));
          },
          child: Text(
            "Sign-Up",
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 18, color: Colors.black),
          ),
        )
      ],
    );
  }
}

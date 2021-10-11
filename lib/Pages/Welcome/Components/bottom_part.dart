import 'package:flutter/material.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green, Colors.green.shade400],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight),
            ),
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            print("pressed");
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

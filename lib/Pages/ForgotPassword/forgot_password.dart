import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              RoutingPage.pop(context: context);
            },
          ),
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Email"),
              onChanged: (value) {
                setState(() {
                  email = value.trim();
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
                onpressed: () async {
                  if (email!.trim().isEmpty) {
                    Fluttertoast.showToast(msg: "Please Provide Email");
                  } else {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email!)
                        .whenComplete(() {
                      Fluttertoast.showToast(
                          msg: "Email has been sent to $email ,please verify!");
                    });

                    RoutingPage.pop(context: context);
                  }
                },
                text: "Send Request")
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/bottom_part.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/center_part.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/login_auth_provider.dart';
import 'package:fooddelivery/Pages/LoginScreen/Components/top_part.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController Email = TextEditingController();

  TextEditingController Password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    LoginProvider loginAuthProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TopPart(),
            CenterPartForLogin(
              email: Email,
              password: Password,
              onPressed: () {
                setState(() {
                  isLoading = !isLoading;
                });
              },
              obscuretext: isLoading,
              icon: Icon(isLoading ? Icons.visibility_off : Icons.visibility),
            ),
            BottomPartForLogin(
              onpressed: () {
                loginAuthProvider.loginVaidation(
                    emailAdress: Email, password: Password, context: context);
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/SignUp/Components/signup_auth_provider.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    SignupAuthProvider signupAuthProvider =
        Provider.of<SignupAuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "SignUp",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 29,
                ),
              ),
              Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: "Enter Email"),
                  ),
                  TextFormField(
                    obscureText: isVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                ],
              ),
              MyButton(
                onpressed: () {
                  signupAuthProvider.signupVaidation(
                      fullName: nameController,
                      emailAdress: emailController,
                      password: passwordController,
                      context: context);
                },
                text: "SignUp",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New Member ?",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

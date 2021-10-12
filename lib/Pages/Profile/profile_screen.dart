import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/HomeScreen/hom_screen.dart';
import 'package:fooddelivery/Pages/Profile/profile_auth_provider.dart';
import 'package:fooddelivery/Routes/push.dart';
import 'package:fooddelivery/Widgets/mybutton.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;
  TextEditingController nameController =
      TextEditingController(text: userModel.fullName);
  TextEditingController emailController =
      TextEditingController(text: userModel.emailAddress);
  @override
  Widget build(BuildContext context) {
    ProfileAuthProvider profileAuthProvider =
        Provider.of<ProfileAuthProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xff185C78),
      appBar: AppBar(
        backgroundColor: Color(0xff185C78),
        elevation: 0.0,
        leading: isEdit
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
                icon: Icon(Icons.close))
            : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 26,
                ),
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isEdit = !isEdit;
                });
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
                size: 26,
              ))
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          isEdit == false
              ? Column(
                  children: [
                    textFormField(hintText: userModel.fullName),
                    textFormField(hintText: userModel.emailAddress)
                  ],
                )
              : Column(
                  children: [
                    editTextFormField(controller: nameController),
                    editTextFormField(controller: emailController),
                  ],
                ),
          SizedBox(
            height: 10,
          ),
          isEdit
              ? MyButton(
                  onpressed: () async {
                    profileAuthProvider.profileVaidation(
                        fullName: nameController,
                        emailAdress: emailController,
                        context: context);
                  },
                  text: "Update",
                )
              : Container()
        ],
      ),
    );
  }

  Widget editTextFormField({TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "name",
            hintStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget textFormField({required String hintText}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      // height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
      child: ListTile(
        leading: Text(hintText),
      ),
    );
  }
}

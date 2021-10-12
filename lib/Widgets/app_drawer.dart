import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/HomeScreen/hom_screen.dart';
import 'package:fooddelivery/Pages/LoginScreen/login_screen.dart';
import 'package:fooddelivery/Pages/Profile/profile_screen.dart';
import 'package:fooddelivery/Routes/push.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              // radius: 10,
              backgroundImage: AssetImage("assets/images/profile.jpg"),
            ),
            decoration: BoxDecoration(color: Colors.purple[100]),
            accountName: Text(
              userModel.fullName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            accountEmail: Text(
              userModel.emailAddress,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              RoutingPage.push(context: context, page: ProfileScreen());
            },
            leading: Icon(
              Icons.person,
            ),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              // RoutingPage.goTonext(
              //   context: context,
              //   navigateTo: CartPage(),
              // );
            },
            leading: Icon(
              Icons.shopping_cart_rounded,
            ),
            title: Text("Cart"),
          ),
          ListTile(
            onTap: () {
              // RoutingPage.goTonext(
              //   context: context,
              //   navigateTo: FavoritePage(),
              // );
            },
            leading: Icon(
              Icons.favorite,
            ),
            title: Text("Favorite"),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_basket_sharp,
            ),
            title: Text("My Order"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                  );
            },
            leading: Icon(
              Icons.exit_to_app,
            ),
            title: Text("Log out"),
          )
        ],
      ),
    );
  }
}

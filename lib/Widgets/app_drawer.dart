import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Pages/LoginScreen/login_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/food.jpg")),
            decoration: BoxDecoration(color: Colors.green),
            accountName: Text("Sha Faisal"),
            accountEmail: Text("faisalsha64@gmail.com"),
          ),
          ListTile(
            onTap: () {
              // RoutingPage.goTonext(
              //   context: context,
              //   navigateTo: ProfilePage(),
              // );
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

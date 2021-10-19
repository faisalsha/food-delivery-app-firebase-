import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/Widgets/grid_view_widget.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridViewWidget(
        subCollection: "userFavourite",
        id: FirebaseAuth.instance.currentUser!.uid,
        collection: "favourite");
  }
}

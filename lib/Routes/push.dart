import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoutingPage {
  static push({required BuildContext context, required Widget page}) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return page;
    }));
  }
}

import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final void Function()? onpressed;
  final String text;

  MyButton({required this.onpressed, required this.text});
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onpressed,
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
            widget.text,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final String title;
  const ColorButton(this.title, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor),
      child: Center(
          child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontSize: 15,
            letterSpacing: 2,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      )),
    );
  }
}

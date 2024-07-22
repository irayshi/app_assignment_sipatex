import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(right: 10),
          child: Divider(
            color: color,
          ),
        )),
        Text(
          text,
          style: TextStyle(color: color),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Divider(
            color: color,
          ),
        )),
      ],
    );
  }
}

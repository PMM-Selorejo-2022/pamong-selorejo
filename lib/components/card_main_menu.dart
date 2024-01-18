import 'package:flutter/material.dart';

class CardMainMenu extends StatelessWidget {
  CardMainMenu({Key? key, required this.title, required this.icon})
      : super(key: key);

  String title;
  Image icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 140, height: 140, child: icon),
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        )
      ],
    );
  }
}

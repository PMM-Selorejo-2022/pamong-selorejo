import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 40,
            child: Container(
              width: MediaQuery.of(context).size.width -
                  (MediaQuery.of(context).size.width * 0.1),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 125, 157, 156),
                  borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Pamong, " + name,
                        style:
                            const TextStyle(fontSize: 26, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Image.asset(
            "assets/img/avatarpamong.png",
            height: 80,
            width: 80,
          ),
        ]);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/user.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.pushReplacementNamed(context, '/sign-in');
        context.read<UserProvider>().removeUser();
      },
      child: Row(
        children: const [
          Text(
            "Keluar",
            style: TextStyle(color: Colors.red),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.logout,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}

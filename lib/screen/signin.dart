import 'package:flutter/material.dart';
import 'package:pamong_selorejo/components/network.dart';
import 'package:pamong_selorejo/model/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../network/repo/auth.dart';
import '../provider/user.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    void showMessage(String message) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }

    void execLogin(String email, String password) async {
      AuthRepository repo = Network().authRepository();
      try {
        AlertDialog alert = AlertDialog(
          content: Row(children: [
            const CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loading...")),
          ]),
        );
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        Auth logins = await repo.loginReq(email, password);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", logins.token);
        User user = await repo.meReq(prefs.getString("token")!);
        context.read<UserProvider>().addUser(user);
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home');
      } catch (e) {
        Navigator.pop(context);
        debugPrint("hai");
        showMessage("User atau password salah!");
      }
    }

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 250, 194),
        title: const Text(
          "Sign In",
          style: TextStyle(color: Color.fromARGB(255, 125, 157, 156)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                'assets/img/logo.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email/User",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none),
                    ),
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      prefixIcon: Icon(Icons.password_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Password is required';
                      } else if (value.length < 4) {
                        return 'Password must be at least 4 characters';
                      }
                      return null;
                    },
                    controller: passController,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: (() async {
                  if (_formKey.currentState!.validate()) {
                    execLogin(emailController.text, passController.text);
                  }
                }),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 125, 157, 156),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

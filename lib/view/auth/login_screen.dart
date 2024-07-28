import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/controller/authcontroller.dart';
import 'package:flutter_e_commerce/theme/textstyle.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';
import 'package:flutter_e_commerce/view/auth/signup_screen.dart';
import 'package:flutter_e_commerce/view/widgets/inputtextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "e-shop",
          style: text26_700.copyWith(color: primarycolor),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            children: [
              InputTextField(
                controller: _email,
                mylabel: "Email",
              ),
              const SizedBox(
                height: 20,
              ),
              InputTextField(
                controller: _password,
                mylabel: "Password",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Authcontroller()
                  .Login(_email.text, _password.text, context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primarycolor,
              foregroundColor: white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Login",
              style: text26_700.copyWith(color: white, fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "New Here? ",
                style: text14_400,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                child: Text(
                  "Signup",
                  style: text26_700.copyWith(color: primarycolor, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/controller/authcontroller.dart';
import 'package:flutter_e_commerce/theme/textstyle.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name;
  String? email;
  getuserdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
    });
  }

  @override
  void initState() {
    getuserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        automaticallyImplyLeading: true,
        centerTitle: false,
        backgroundColor: primarycolor,
        title: Text(
          "e-shop",
          style: text26_700.copyWith(color: white, fontSize: 20),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            "Name: $name",
            style: text18_700,
          ),
          Text(
            "Email: $email",
            style: text18_700,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () async {
            await Authcontroller().Signout(context);
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
            "Log Out",
            style: text26_700.copyWith(color: white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

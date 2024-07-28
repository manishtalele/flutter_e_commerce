// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/model/usermodel.dart';
import 'package:flutter_e_commerce/theme/themedata.dart';
import 'package:flutter_e_commerce/view/auth/login_screen.dart';
import 'package:flutter_e_commerce/view/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserModel? userDetail;

class Authcontroller {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  SignUp(
      String name, String email, String password, BuildContext context) async {
    try {
      if (name.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel user = UserModel(credential.user!.uid, name, email, password);
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(credential.user!.uid)
            .set(user.toMap())
            .whenComplete(() async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('userLogged', true);
          await prefs.setString('uid', userDetail!.uid.toString());
          await prefs.setString('name', userDetail!.name.toString());
          await prefs.setString('email', userDetail!.email.toString());
          await prefs.setString('password', userDetail!.password.toString());
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        });

        userDetail = user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: bgcolor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: const Text(
            'The account already exists for that email.',
            style: TextStyle(color: Colors.red),
          ),
        ));
        if (kDebugMode) {
          print('The account already exists for that email.');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: bgcolor2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: const Text(
          'Please Provide all Correct Details',
          style: TextStyle(color: Colors.red),
        ),
      ));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Login(String email, String password, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((docSnapshot) async {
        var data = docSnapshot.data();
        userDetail = UserModel.fromMap(data!);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('userLogged', true);
        await prefs.setString('uid', userDetail!.uid.toString());
        await prefs.setString('name', userDetail!.name.toString());
        await prefs.setString('email', userDetail!.email.toString());
        await prefs.setString('password', userDetail!.password.toString());
      }).whenComplete(() => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HomeScreen())));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('userLogged', true);
      await prefs.setString('uid', userDetail!.uid.toString());
      await prefs.setString('name', userDetail!.name.toString());
      await prefs.setString('email', userDetail!.email.toString());
      await prefs.setString('password', userDetail!.password.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: bgcolor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: const Text(
            'No user found for that email.',
            style: TextStyle(color: Colors.red),
          ),
        ));
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: bgcolor2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          content: const Text(
            'Wrong password provided for that user.',
            style: TextStyle(color: Colors.red),
          ),
        ));
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: bgcolor2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: const Text(
          'Please Provide Correct Login Details',
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }

  Signout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userLogged', false);
    await FirebaseAuth.instance.signOut().whenComplete(
          () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LoginScreen())),
        );
  }
}

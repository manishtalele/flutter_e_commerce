import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;

  UserModel(this.uid, this.name, this.email, this.password);

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = FirebaseAuth.instance.currentUser!.uid;
    name = map["name"];
    email = map["email"];
    password = map["password"];
  }

  Map<String, dynamic> toMap() {
    return {"uid": uid, "name": name, "email": email, "password": password};
  }
}

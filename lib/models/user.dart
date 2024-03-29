import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String password;
  // final String profilepic;
  // final String bio;
  // final String phone;

  const User({
    required this.email,
    required this.uid,
    required this.username,
    required this.password,
    // required this.profilepic,
    // required this.bio,
    // required this.phone,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "password": password,
    // "profilepic": profilepic,
    // "bio": bio,
    // "phone": phone,
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      password: snapshot['password'],
      email: snapshot['email'],
      uid: snapshot['uid'],
      // profilepic: snapshot['profilepic'],
      // bio: snapshot["bio"],
      // phone: snapshot["phone"],
    );
  }
}
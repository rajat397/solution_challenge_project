import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solution_challenge_project/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = auth.currentUser!;

    DocumentSnapshot snap =
    await firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  //sign up user

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    // String profilepic ="",
    // // "https://firebasestorage.googleapis.com/v0/b/uniconnect-62628.appspot.com/o/default_prof.jpg?alt=media&token=2488a918-e680-4445-a04b-5627c62dcf46",
    // String bio = "Hello",
    // String phone = "Not yet registered",
    // // required Uint8List file,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
        if (!email.contains('@')) {
          res = "Please enter your iiita.ac.in email address.";
          return res;
        }
        List<String>parts = email.split("@");
        if (parts.length != 2 || parts[1].isEmpty) {
          res = "Invalid email format. Please include a valid domain name.";
          return res;
        }

        //register user
        print("Helllo");
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          password: password,
          // profilepic: profilepic,
          // phone: phone,
          // bio: bio,

        );

        // Send verification email
        // await cred.user!.sendEmailVerification();

        //add user to our database
        await firestore.collection('users').doc(cred.user!.uid).set(
          user.toJson(),
        );

        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  // logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {

        UserCredential cred = await auth.signInWithEmailAndPassword(
            email: email, password: password);

        // if (cred.user!.emailVerified) {
          res = "Success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

}
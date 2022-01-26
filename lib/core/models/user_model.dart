import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String fullname;
  final String username;
  final String photoUrl;
  final DateTime dob;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.photoUrl,
      required this.uid,
      required this.fullname,
      required this.email,
      required this.dob,
      required this.followers,
      required this.following});

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      fullname: snapshot["fullname"],
      dob: snapshot["dob"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "fullname": fullname,
        "dob": dob,
        "followers": followers,
        "following": following,
      };
}

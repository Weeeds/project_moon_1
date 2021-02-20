import 'package:cloud_firestore/cloud_firestore.dart';

class mUser {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;

  mUser({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
  });

  factory mUser.fromDocument(DocumentSnapshot doc) {
    return mUser(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
      bio: doc['bio'],
    );
  }
}

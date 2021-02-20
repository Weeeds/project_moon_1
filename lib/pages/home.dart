import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_moon_1/models/user.dart';
import 'package:project_moon_1/pages/activity_feed.dart';
import 'package:project_moon_1/pages/profile.dart';
import 'package:project_moon_1/pages/search.dart';
import 'package:project_moon_1/pages/timeline.dart';
import 'package:project_moon_1/pages/upload.dart';

import 'broadcast_list.dart';
import 'create_account.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final DateTime timestamp = DateTime.now();

mUser currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    // Detects when user signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error singing in : $err');
    });
    // Re-authenticate user upon opening app
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    // 1) check if user exists in users collection in database (according to their id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot mDoc = await usersRef.doc(user.id).get();

    if (!mDoc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page
      final username = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CreateAccount()));

      // 3) get username from create account, use it to make new user document in users collection
      usersRef.doc(user.id).set({
        "id": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });
      mDoc = await usersRef.doc(user.id).get();
    }
    currentUser = mUser.fromDocument(mDoc);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    if (pageIndex != 2) {
      pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      logout();
    }
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
          BroadcastList(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_outlined),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_outlined, size: 35.0),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
          ),
        ],
      ),
    );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Weeds',
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login,
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/google_signin_button.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}

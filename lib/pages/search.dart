import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_moon_1/pages/home.dart';
import 'package:project_moon_1/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query) {
    Future<QuerySnapshot> users =
        usersRef.where("display name", isGreaterThanOrEqualTo: query).get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  AppBar buildSearchField() {
    return AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          decoration: InputDecoration(
            hintText: "Search for a user...",
            filled: true,
            prefixIcon: Icon(
              Icons.account_box,
              size: 28.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => print('cleared'),
            ),
          ),
          onFieldSubmitted: handleSearch,
        ));
  }

  Container buildNoContent() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/search.svg',
              height: 300.0,
            ),
            Text(
              "Find Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 60.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSearchResults() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}

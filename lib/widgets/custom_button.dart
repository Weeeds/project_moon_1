import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /* final String id;
  final String title;
  final String username;
  final String backgroundImage;
  final int listeners;
  final int likes;

  CustomButton(this.id, this.title, this.username, this.backgroundImage,
      this.listeners, this.likes);*/

  CustomButton({@required this.onPressed});
  GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 12.0, right: 10.0),
            child: Container(
              //margin: EdgeInsets.only(left: 8.0),
              //padding: EdgeInsets.all(10.0),
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: AssetImage('assets/images/alice.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          //SizedBox(width: 5.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Live Stream Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0, bottom: 2.0),
                child: Text('Username'),
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.favorite,
                    size: 9.0,
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Icon(
                    Icons.person,
                    size: 11.0,
                  ),
                  SizedBox(
                    width: 1.0,
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

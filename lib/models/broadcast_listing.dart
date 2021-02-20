import 'package:flutter/material.dart';

class BroadcastListing {
  final String id;
  final String title;
  final String username;
  final String backgroundImage;
  final int listeners;
  final int likes;

  const BroadcastListing({
    @required this.id,
    @required this.title,
    @required this.username,
    @required this.backgroundImage,
    this.listeners = 0,
    this.likes = 0,
  });
}

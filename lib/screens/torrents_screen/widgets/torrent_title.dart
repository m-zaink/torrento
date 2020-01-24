import 'package:flutter/material.dart';

class TorrentTitle extends StatelessWidget {
  final String text;
  
  TorrentTitle({
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
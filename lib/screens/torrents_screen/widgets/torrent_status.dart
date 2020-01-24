import 'package:flutter/material.dart';

class TorrentStatus extends StatelessWidget {
  final String text;
  final Color color;

  TorrentStatus({
    @required this.text,
    @required this.color,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      color: color,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Torrento'),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildText(text: '1. Tap to start a torrent.'),
            buildText(text: ''),
            buildText(text: '2. Double tap to pause a torrent.'),
            buildText(text: ''),
            buildText(text: '3. Long press to remove a torrent.'),
            buildText(text: ''),
            buildColorInfoRow(
              text: 'Running torrent',
              color: Colors.indigo,
            ),
            buildText(text: ''),
            buildColorInfoRow(
              text: 'Paused torrent',
              color: Colors.orange,
            ),
            buildText(text: ''),
            buildColorInfoRow(
              text: 'Completed torrent',
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Row buildColorInfoRow({
    @required String text,
    @required Color color,
  }) {
    return Row(
      children: <Widget>[
        Container(
          height: 20,
          width: 20,
          color: color,
        ),
        SizedBox(
          width: 10,
        ),
        buildText(text: text)
      ],
    );
  }

  Text buildText({@required String text}) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
    );
  }
}

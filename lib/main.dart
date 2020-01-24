import 'package:flutter/material.dart';
import 'package:torrento_app/screens/home_screen.dart';

void main() => runApp(TorrentoApp());

class TorrentoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TorrentoAppState();
}

class _TorrentoAppState extends State<TorrentoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torrento_app/bloc/bloc.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/people_searching.png'),
            Text(''),
            Text('Error!'),
            Text(''),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              ),
              color: Colors.indigo,
              child: Text(
                'Jeez. Okay!',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(ReturnToLoginEvent());
              },
            )
          ],
        ),
      ),
    );
  }
}

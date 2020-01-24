import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torrento_app/bloc/bloc.dart';
import 'package:torrento_app/screens/error_screen.dart';
import 'package:torrento_app/screens/loading_screen.dart';
import 'package:torrento_app/screens/torrents_screen/torrents_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case AuthenticationUnsuccessful:
              return ErrorScreen();
            case AuthenticationSuccessful:
              return TorrentsScreen();
            case AuthenticatingState:
              return LoadingScreen();
            default:
              return LoginPage();
          }
        },
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String password;
  String serverIp;
  int serverPort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Torrento'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/search.jpg'),
                buildTextFormField(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter username',
                    forField: Field.username),
                buildSizedBox(height: 20),
                buildTextFormField(
                    prefixIcon: Icon(Icons.keyboard),
                    hintText: 'Enter password',
                    obscureText: true,
                    forField: Field.password),
                buildSizedBox(height: 20),
                buildTextFormField(
                  prefixIcon: Icon(Icons.network_check),
                  hintText: 'Enter IP',
                  forField: Field.serverIp,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                buildSizedBox(height: 20),
                buildTextFormField(
                  prefixIcon: Icon(Icons.power_input),
                  hintText: 'Enter port',
                  forField: Field.serverPort,
                  keyboardType: TextInputType.number,
                ),
                buildSizedBox(height: 20),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  color: Colors.indigo,
                  splashColor: Colors.indigoAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Log In',
                        style: TextStyle(color: Colors.white),
                      ),
                      buildSizedBox(width: 10.0),
                      Icon(
                        Icons.input,
                        color: Colors.white,
                      )
                    ],
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(LoginEvent(
                        username: username,
                        password: password,
                        serverIP: serverIp,
                        serverPort: serverPort));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox({double height, double width}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget buildTextFormField({
    @required String hintText,
    @required Icon prefixIcon,
    @required Field forField,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: (changedValue) {
        switch (forField) {
          case Field.username:
            username = changedValue;
            break;
          case Field.password:
            password = changedValue;
            break;
          case Field.serverIp:
            serverIp = changedValue;
            break;
          case Field.serverPort:
            serverPort = int.parse(changedValue);
            break;
        }
      },
    );
  }
}

enum Field { username, password, serverIp, serverPort }

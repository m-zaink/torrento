import 'package:equatable/equatable.dart';
import 'package:torrento_app/bloc/bloc.dart';

abstract class AuthenticationEvent extends Equatable {
}

class LoginEvent extends AuthenticationEvent {
  final String username;
  final String password;
  final String serverIP;
  final int serverPort;
  LoginEvent(
      {this.username, this.password, this.serverIP, this.serverPort});

  @override
  List<Object> get props => [username, password, serverIP, serverPort];
}

class LogoutEvent extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}

class ReturnToLoginEvent extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}
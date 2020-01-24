import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSuccessful extends AuthenticationState {
  @override
  List<Object> get props => null;
}

class AuthenticationUnsuccessful extends AuthenticationState {
  @override
  List<Object> get props => null;
}

class AuthenticatingState extends AuthenticationState {
  @override
  List<Object> get props => null;
}

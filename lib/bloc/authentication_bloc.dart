import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:torrento/torrento.dart';
import 'package:torrento_app/q_bit_torrent_singleton.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  QbitTorrentController qbitTorrentController;

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    switch (event.runtimeType) {
      case LoginEvent:
        LoginEvent logInEvent = (event as LoginEvent);
        qbitTorrentController = QBitTorrentSingleton.init(
            serverIP: logInEvent.serverIP, serverPort: logInEvent.serverPort);

        yield AuthenticatingState();

        try {
          await qbitTorrentController.logIn(
              logInEvent.username, logInEvent.password);
          yield AuthenticationSuccessful();
        } catch (e) {
          print(e);
          yield AuthenticationUnsuccessful();
        }
        break;
      case LogoutEvent:
        await qbitTorrentController.logOut();
        yield InitialAuthenticationState();
        break;
      case ReturnToLoginEvent:
        yield InitialAuthenticationState();
        break;
    }
  }
}

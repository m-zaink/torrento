import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:torrento/torrento.dart';
import 'package:torrento_app/q_bit_torrent_singleton.dart';
import './bloc.dart';

class TorrentHandlerBloc
    extends Bloc<TorrentHandlerEvent, TorrentHandlerState> {
  QbitTorrentController qbitTorrentController;

  @override
  TorrentHandlerState get initialState {
    qbitTorrentController = QBitTorrentSingleton.shared;
    return InitialTorrentHandlerState(List<dynamic>());
  }

  @override
  Stream<TorrentHandlerState> mapEventToState(
    TorrentHandlerEvent event,
  ) async* {
    switch (event.runtimeType) {
      case StartTorrent:
        await qbitTorrentController.startTorrent(event.torrentHash);
        break;
      case PauseTorrent:
        await qbitTorrentController.pauseTorrent(event.torrentHash);
        break;
      case RemoveTorrent:
        await qbitTorrentController.removeTorrent(event.torrentHash);
        break;
      case StartAllTorrents:
        await qbitTorrentController.startAllTorrents();
        break;
      case StopAllTorrents:
        await qbitTorrentController.stopAllTorrents();
        break;
      case RemoveAllTorrents:
        await qbitTorrentController.removeAllTorrents();
        break;
      default:
        List<dynamic> rawTorrents = await qbitTorrentController.getTorrentsList();
        yield UpdateTorrents(rawTorrents);
    }

//    List<dynamic> rawTorrents = await qbitTorrentController.getTorrentsList();

//    yield UpdateTorrents(rawTorrents);
  }
}

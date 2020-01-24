import 'package:equatable/equatable.dart';

abstract class TorrentHandlerEvent extends Equatable {
  final String torrentHash;
  TorrentHandlerEvent({this.torrentHash});

  @override
  List<Object> get props => [torrentHash];
}

class RefreshTorrentsEvent extends TorrentHandlerEvent {}

class StartTorrent extends TorrentHandlerEvent {
  StartTorrent({String torrentHash}) : super(torrentHash: torrentHash);
}

class PauseTorrent extends TorrentHandlerEvent {
  PauseTorrent({String torrentHash}) : super(torrentHash: torrentHash);
}

class RemoveTorrent extends TorrentHandlerEvent {
  RemoveTorrent({String torrentHash}) : super(torrentHash: torrentHash);
}

class RemoveAllTorrents extends TorrentHandlerEvent {

}

class StartAllTorrents extends TorrentHandlerEvent {

}

class StopAllTorrents extends TorrentHandlerEvent {

}


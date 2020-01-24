import 'package:equatable/equatable.dart';

abstract class TorrentHandlerState extends Equatable {
  final List<dynamic> torrents;
  TorrentHandlerState({this.torrents});

  @override
  List<Object> get props => [torrents];
}

class InitialTorrentHandlerState extends TorrentHandlerState {
  InitialTorrentHandlerState(List<dynamic> torrents) : super(torrents: torrents);
}

class UpdateTorrents extends TorrentHandlerState {
  UpdateTorrents(List<dynamic> torrents) : super(torrents: torrents);
}
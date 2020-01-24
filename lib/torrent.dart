class Torrent {
  String hash;
  String title;
  String status;

  Future<double> getProgress() async {
    // TODO : Implement
    return Future.value(10.0);
  }

  Future<bool> start() async {
    // TODO: Implement
  }

  Future<bool> stop() async {
    // TODO: Implement
  }
}

enum TorrentState {
  running, 
  paused,
  stopped,

}
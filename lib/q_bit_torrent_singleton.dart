import 'package:meta/meta.dart';
import 'package:torrento/torrento.dart';

class QBitTorrentSingleton {
  static QbitTorrentController shared;

  static QbitTorrentController init({@required String serverIP, @required int serverPort}) {
    shared = QbitTorrentController(serverIP, serverPort);
    return shared;
  }
}
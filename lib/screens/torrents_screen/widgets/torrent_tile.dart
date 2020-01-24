import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torrento_app/bloc/bloc.dart';
import 'package:torrento_app/bloc/torrent_handler_bloc.dart';
import 'package:torrento_app/screens/torrents_screen/widgets/torrent_progress_indicator.dart';
import 'package:torrento_app/screens/torrents_screen/widgets/torrent_status.dart';
import 'package:torrento_app/screens/torrents_screen/widgets/torrent_title.dart';

class TorrentTile extends StatefulWidget {
  final dynamic torrent;

  TorrentTile({this.torrent});

  @override
  _TorrentTileState createState() => _TorrentTileState(torrent);

}

class _TorrentTileState extends State<TorrentTile> {
  String torrentHash;
  String title;
  String status;
  double progress;
  Color activeTrackColor;



  _TorrentTileState(dynamic torrent) {
    this.torrentHash = torrent['hash'];
    this.title = torrent['name'];
    this.status = getStatus(state: torrent['state']);
    this.progress = torrent['progress'];
    this.activeTrackColor = getColorFor(status: status);
    print('title $title');
  }

  @override
  void initState() {
    super.initState();
    refreshTorrentsFrom(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        enableFeedback: true,
        onTap: () {
          log('Tapped');

          BlocProvider.of<TorrentHandlerBloc>(context)
              .add(StartTorrent(torrentHash: torrentHash));
        },
        onDoubleTap: () {
          log('Double Tap');

          BlocProvider.of<TorrentHandlerBloc>(context)
              .add(PauseTorrent(torrentHash: torrentHash));
        },
        onLongPress: () {
          log('Long Press');

          showDialog(
              builder: (_) => buildAlertDialog(
                    torrentHash: torrentHash,
                  ),
              context: this.context);
        },
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TorrentTitle(
                text: widget.torrent['name'],
              ),
              SizedBox(height: 5.0),
              TorrentStatus(
                text: getStatus(
                  state: widget.torrent['state'],
                ),
                color: getColorFor(
                  status: getStatus(
                    state: widget.torrent['state'],
                  ),
                ),
              ),
              TorrentProgressIndicator(
                progress: progress,
                activeTrackColor: getColorFor(
                    status: getStatus(state: widget.torrent['state'])),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getStatus({@required String state}) {
    switch (state) {
      case 'error':
      case 'uploading':
      case 'downloading':
        return state;
      default:
        return state.substring(0, state.length - 2);
    }
  }

  Color getColorFor({String status}) {
    log(status);
    switch (status) {
      case 'downloading':
        return Colors.indigo;
      case 'checking':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }

  AlertDialog buildAlertDialog({String torrentHash}) {
    return AlertDialog(
      title: Text('Are you sure?'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('This will remove the torrent from the client.'),
            Text(''),
            Text('Click \'Yes\' to confirm.'),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          color: Colors.white,
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          color: Colors.indigo,
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            BlocProvider.of<TorrentHandlerBloc>(context)
                .add(RemoveTorrent(torrentHash: torrentHash));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void refreshTorrentsFrom({BuildContext context}) {
    Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => BlocProvider.of<TorrentHandlerBloc>(context).add(
        RefreshTorrentsEvent(),
      ),
    );
  }
}

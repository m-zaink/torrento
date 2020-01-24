import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torrento_app/bloc/bloc.dart';
import 'package:torrento_app/bloc/torrent_handler_bloc.dart';
import 'package:torrento_app/screens/info_screen.dart';
import 'package:torrento_app/screens/torrents_screen/widgets/torrent_tile.dart';

class TorrentsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TorrentsScreenState();
}

class _TorrentsScreenState extends State<TorrentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TorrentHandlerBloc>(
      child: BlocBuilder<TorrentHandlerBloc, TorrentHandlerState>(
        builder: (context, state) {
          if (state is InitialTorrentHandlerState) {
            BlocProvider.of<TorrentHandlerBloc>(context).add(
              RefreshTorrentsEvent(),
            );
          }
          return TorrentPage(torrents: state.torrents);
        },
      ),
      create: (BuildContext context) => TorrentHandlerBloc(),
    );
  }
}

class TorrentPage extends StatefulWidget {
  final List<dynamic> torrents;

  const TorrentPage({Key key, @required this.torrents}) : super(key: key);

  @override
  _TorrentPageState createState() => _TorrentPageState();
}

class _TorrentPageState extends State<TorrentPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      refreshTorrentsFrom(context: context);
    });
    refreshTorrentsFrom(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Torrento'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: widget.torrents.length == 0
          ? Center(
              child: Text('No Torrents To Show'),
            )
          : ListView.builder(
              itemCount: widget.torrents.length * 2,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return TorrentTile(
                    torrent: widget.torrents[index ~/ 2],
                  );
                } else {
                  return buildDivider();
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          BlocProvider.of<TorrentHandlerBloc>(context)
              .add(RefreshTorrentsEvent());
        },
      ),
      drawer: buildDrawer(context: context),
    );
  }

  Divider buildDivider() {
    return Divider(
      color: Colors.black54,
      height: 5.0,
      endIndent: 20.0,
      indent: 20.0,
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

  Drawer buildDrawer({@required BuildContext context}) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Center(
              child: Text(
                'Torrento',
                style: TextStyle(color: Colors.white, fontSize: 32.0),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              BlocProvider.of<TorrentHandlerBloc>(context)
                  .add(StartAllTorrents());
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.play_arrow,
              color: Colors.indigo,
            ),
            title: Text('Start All'),
          ),
          ListTile(
            onTap: () {
              BlocProvider.of<TorrentHandlerBloc>(context)
                  .add(StopAllTorrents());
              Navigator.pop(context);
            },
            leading: Icon(
              Icons.stop,
              color: Colors.indigo,
            ),
            title: Text('Stop All'),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                child: buildAlertDialog(context: context),
              );
//              Navigator.pop(context);
            },
            leading: Icon(
              Icons.bubble_chart,
              color: Colors.indigo,
            ),
            title: Text('Remove All'),
          ),
          ListTile(
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
            },
            leading: Transform.rotate(
              angle: pi,
              child: Icon(
                Icons.exit_to_app,
                color: Colors.indigo,
              ),
            ),
            title: Text('Log Out'),
          ),
        ],
      ),
    );
  }

  Widget buildAlertDialog({@required BuildContext context}) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: Text(
          'Are You Sure?',
          style: TextStyle(color: Colors.indigo),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  '\nThis will remove all the torrents from the client.\n\nClick \'Yes\' to confirm.'),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.indigo, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
          CupertinoButton(
            child: Text(
              'Yes',
              style:
                  TextStyle(color: Colors.indigo, fontWeight: FontWeight.w300),
            ),
            onPressed: () {
              BlocProvider.of<TorrentHandlerBloc>(context)
                  .add(RemoveAllTorrents());
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }

    return AlertDialog(
      title: Text('Are you sure?'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('This will remove all the torrents from the client.'),
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
                .add(RemoveAllTorrents());
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

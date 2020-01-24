import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torrento_app/bloc/bloc.dart';
import 'package:torrento_app/bloc/torrent_handler_bloc.dart';
import 'package:torrento_app/screens/info_screen.dart';
import 'package:torrento_app/screens/loading_screen.dart';
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
          : Container(
              child: ListView.builder(
                itemCount: widget.torrents.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      TorrentTile(
                        torrent: widget.torrents[index],
                      ),
                      buildDivider(),
                    ],
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          BlocProvider.of<TorrentHandlerBloc>(context)
              .add(RefreshTorrentsEvent());
        },
      ),
      drawer: Drawer(
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
                BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
              },
              leading: Transform.rotate(
                angle: pi,
                child: Icon(
                  Icons.exit_to_app,
                ),
              ),
              title: Text('Log Out'),
            )
          ],
        ),
      ),
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
}

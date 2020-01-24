import 'package:flutter/material.dart';

class TorrentProgressIndicator extends StatelessWidget {
  final double progress;
  final Color activeTrackColor;

  TorrentProgressIndicator({
    @required this.progress,
    this.activeTrackColor = Colors.indigo,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      child: Slider(
        min: 0,
        max: 100,
        value: progress,
        onChanged: (double value) {},
      ),
      data: SliderThemeData(
        trackHeight: 5.0,
        activeTrackColor: activeTrackColor,
        overlayColor: Colors.transparent,
        thumbShape: RoundSliderThumbShape(
          disabledThumbRadius: 0.0,
          enabledThumbRadius: 0.0,
        ),
      ),
    );
  }
}
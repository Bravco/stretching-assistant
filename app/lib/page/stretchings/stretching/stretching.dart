import 'package:flutter/material.dart';

//Data
import 'package:app/data/stretchings.dart';
import 'package:app/data/stretching.dart';

//Pages
import 'package:app/page/stretchings/stretching/settings.dart';
import 'package:app/page/stretchings/stretching/viewer.dart';

class StretchingPage extends StatefulWidget {
  final bool isCustom;
  final int stretchingIndex;

  const StretchingPage({
    Key? key,
    this.isCustom = false,
    required this.stretchingIndex,
  }) : super(key: key);

  @override
  State<StretchingPage> createState() => _StretchingPageState();
}

class _StretchingPageState extends State<StretchingPage> {
  int index = 0;

  refresh() {
    setState(() {
      widget.isCustom
      ? laps = customStretchings[widget.stretchingIndex].stretches.length
      : laps = stretchings[widget.stretchingIndex].stretches;

      index = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return StretchingSettingsPage(
        isCustom: widget.isCustom,
        stretchingIndex: widget.stretchingIndex,
        notifyParent: refresh,
      );
    } else if (index == 1) {
      return StretchingViewerPage(
        isCustom: widget.isCustom,
        stretchingIndex: widget.stretchingIndex,
      );
    } else {
      return const Text("Error");
    }
  }
}
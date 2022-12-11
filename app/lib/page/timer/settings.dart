import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Widgets
import 'package:app/widget/appbar.dart';
import 'package:app/widget/timer/laps_inputfield.dart';
import 'package:app/widget/timer/work_inputfield.dart';
import 'package:app/widget/timer/rest_inputfield.dart';

class TimerSettingsPage extends StatefulWidget {
  final VoidCallback? voidCallback;

  const TimerSettingsPage({
    Key? key,
    required this.voidCallback,
  }) : super(key: key);

  @override
  State<TimerSettingsPage> createState() => _TimerSettingsPageState();
}

class _TimerSettingsPageState extends State<TimerSettingsPage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPf(title: "Settings"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LapsInputfield(refresh: refresh),
            const SizedBox(height: 48,),
            WorkInputfield(refresh: refresh),
            const SizedBox(height: 48,),
            RestInputfield(refresh: refresh),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: widget.voidCallback,
        backgroundColor: utils.color10,
        child: const Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
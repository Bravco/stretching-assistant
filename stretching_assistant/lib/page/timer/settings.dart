import 'package:flutter/material.dart';

// Data
import 'package:stretching_assistant/data/timer.dart';

// Widget
import 'package:stretching_assistant/widget/inputfield.dart';

class TimerSettingsPage extends StatefulWidget {
  const TimerSettingsPage({super.key});

  @override
  State<TimerSettingsPage> createState() => _TimerSettingsPageState();
}

class _TimerSettingsPageState extends State<TimerSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Inputfield(
                  value: laps,
                  label: "laps",
                  onIncrease: () => setState(() => laps != maxLaps ? laps++ : laps),
                  onDecrease: () => setState(() => laps != 1 ? laps-- : laps),
                ),
                Inputfield(
                  value: cooldownTime,
                  isTime: true,
                  label: "cooldown time",
                  onIncrease: () => setState(() => cooldownTime != maxTime ? cooldownTime++ : cooldownTime),
                  onDecrease: () => setState(() => cooldownTime != 1 ? cooldownTime-- : cooldownTime),
                ),
                Inputfield(
                  value: stretchTime,
                  isTime: true,
                  label: "stretch time",
                  onIncrease: () => setState(() => stretchTime != maxTime ? stretchTime++ : stretchTime),
                  onDecrease: () => setState(() => stretchTime != 1 ? stretchTime-- : stretchTime),
                ),
                Inputfield(
                  value: relaxTime,
                  isTime: true,
                  label: "relax time",
                  onIncrease: () => setState(() => relaxTime != maxTime ? relaxTime++ : relaxTime),
                  onDecrease: () => setState(() => relaxTime != 1 ? relaxTime-- : relaxTime),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(laps),
          child: const Icon(Icons.done),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
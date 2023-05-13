import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stretching_assistant/data/exercises.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/timer.dart';

// Pub
import 'package:audioplayers/audioplayers.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TrainingTimerPage extends StatefulWidget {
  final Training training;

  const TrainingTimerPage({
    super.key,
    required this.training,
  });

  @override
  State<TrainingTimerPage> createState() => _TrainingTimerPageState();
}

class _TrainingTimerPageState extends State<TrainingTimerPage> {
  Timer? timer;
  bool isPaused = true;

  List<int> times = [];
  int currentLap = 0;
  late int lapsTmp;
  late int cooldownTimeTmp;
  late int relaxTimeTmp;
  late int maxSecs = cooldownTimeTmp;
  late int secs = cooldownTimeTmp;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ smoothener), (_) {
      if (!isPaused) {
        if (secs > 0 && currentLap != lapsTmp) {
          setState(() => secs--);
          if (secs == 0) {
            nextLap();
            AudioPlayer().play(AssetSource("alarm.mp3"));
          }
        }

        if (currentLap == lapsTmp) secs = 0;
      }
    });

    if (!mounted) timer?.cancel();

    setupTimes();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void setupTimes() {
    setState(() {
      lapsTmp = widget.training.exercises.length * 2;
      cooldownTimeTmp = cooldownTime * smoothener;
      relaxTimeTmp = relaxTime * smoothener;

      times = [];

      for (int i = 0; i < lapsTmp; i++) {
        if (i == 0) {
          times.add(cooldownTimeTmp);
        } else {
          if (i % 2 != 0) {
            int exerciseTime = widget.training.exercises[(i-1)~/2].value.toDuration().inSeconds * smoothener;
            times.add(exerciseTime);
          } else {
            times.add(relaxTimeTmp);
          }
        }
      }
    });
  }

  void restartTimer() {
    setState(() {
      isPaused = true;

      secs = times[0];
      maxSecs = times[0];
      currentLap = 0;
    });
  }

  void toggleTimer() {
    setState(() => isPaused = !isPaused);
  }

  void nextLap() {
    if (currentLap < lapsTmp && currentLap + 1 != lapsTmp) {
      setState(() {
        currentLap++;
        secs = times[currentLap];
        maxSecs = times[currentLap];
      });
    } else if (currentLap + 1 == lapsTmp) {
      setState(() {
        currentLap++;
        secs = 0;
      });
    }
  }

  void previousLap() {
    if (currentLap > 0) {
      setState(() {
        currentLap--;
        secs = times[currentLap];
        maxSecs = times[currentLap];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted = currentLap == lapsTmp;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              buildTopBlock(),
              buildMiddleBlock(),
              currentLap % 2 != 0 ? Image(
                image: exercises[widget.training.exercises[currentLap  ~/ 2].key]!.image,
                height: 160,
              ) : Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  currentLap == 0
                  ? "Get Ready"
                  : currentLap == lapsTmp
                    ? "Completed"
                    : "Relax",
                  style: TextStyle(
                    color: currentLap % 2 != 0 || currentLap == lapsTmp
                      ? Utils.primaryColor
                      : Utils.textColorAlt,
                    fontWeight: FontWeight.w300,
                    fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: isCompleted
        ? FloatingActionButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Icon(Icons.done),
        )
        : FloatingActionButton(
          onPressed: () => toggleTimer(),
          child: !isPaused ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget buildTopBlock() {
    return Column(
      children: [
        Container(
          height: 128,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Utils.primaryColorAlt,
                Utils.primaryColorAlt,
                Utils.secondaryBackgroundColor,
                Utils.secondaryBackgroundColor,
              ],
              stops: [
                0.0,
                (maxSecs - secs) / (maxSecs / 1),
                (maxSecs - secs) / (maxSecs / 1),
                1.0,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${currentLap ~/ 2}/${widget.training.exercises.length}",
                      style: const TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 48,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "laps\nfinished",
                      style: TextStyle(
                        color: Utils.textColorAlt,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      label: const Text("Give up"),
                      icon: const Icon(Icons.stop_circle),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => restartTimer(),
                      label: const Text("Restart"),
                      icon: const Icon(Icons.replay),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        LinearProgressIndicator(
          value: (maxSecs - secs) / (maxSecs / 1),
          valueColor: AlwaysStoppedAnimation(Utils.primaryColor),
          backgroundColor: Utils.primaryBackgroundColor,
          minHeight: 3,
        ),
      ],
    );
  }

  Widget buildMiddleBlock() {
    return Stack(
      children: [
        ClipRRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: .9,
            child: buildTimer(),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Align(
              alignment: Alignment.centerRight,
              child: (currentLap+1) ~/ 2 != widget.training.exercises.length ? Padding(
                padding: const EdgeInsets.only(top: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: currentLap != lapsTmp
                      ? () => nextLap()
                      : null,
                      icon: Icon(
                        Icons.skip_next,
                        size: 32,
                        color: currentLap != lapsTmp
                        ? Utils.textColor
                        : Utils.textColorAlt,
                      ),
                    ),
                    Image(
                      image: exercises[widget.training.exercises[(currentLap+1) ~/ 2].key]!.image,
                      width: 64,
                    ),
                  ],
                ),
              ) : Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: currentLap != lapsTmp
                  ? () => nextLap()
                  : null,
                  icon: Icon(
                    Icons.skip_next,
                    size: 32,
                    color: currentLap != lapsTmp
                    ? Utils.textColor
                    : Utils.textColorAlt,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ((currentLap+1) ~/ 2)-1 > 0 ? Padding(
                padding: const EdgeInsets.only(top: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: currentLap != 0
                      ? () => previousLap()
                      : null,
                      icon: Icon(
                        Icons.skip_previous,
                        size: 32,
                        color: currentLap != 0
                        ? Utils.textColor
                        : Utils.textColorAlt,
                      ),
                    ),
                    Image(
                      image: exercises[widget.training.exercises[((currentLap+1) ~/ 2)-1].key]!.image,
                      width: 64,
                    ),
                  ],
                ),
              ) : Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  onPressed: currentLap != 0
                  ? () => previousLap()
                  : null,
                  icon: Icon(
                    Icons.skip_previous,
                    size: 32,
                    color: currentLap != 0
                    ? Utils.textColor
                    : Utils.textColorAlt,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimer() {
    return SfRadialGauge(
      animationDuration: 300,
      axes: <RadialAxis>[
        RadialAxis(
          maximum: 1,
          showLabels: false,
          showTicks: false,
          startAngle: 135,
          endAngle: 45,
          radiusFactor: .7,
          canScaleToFit: true,
          axisLineStyle: const AxisLineStyle(
            thickness: .03,
            thicknessUnit: GaugeSizeUnit.factor,
            cornerStyle: CornerStyle.bothCurve,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: (maxSecs - secs) / (maxSecs / 1),
              width: .03,
              color: Utils.primaryColor,
              sizeUnit: GaugeSizeUnit.factor,
              cornerStyle: CornerStyle.startCurve,
            ),
            MarkerPointer(
              value: (maxSecs - secs) / (maxSecs / 1),
              markerWidth: 24,
              markerHeight: 24,
              markerType: MarkerType.circle,
              color: Utils.primaryColor,
              elevation: 8,
              enableAnimation: true,
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              horizontalAlignment: GaugeAlignment.center,
              verticalAlignment: GaugeAlignment.center,
              widget: currentLap == lapsTmp
              ? Icon(
                Icons.check,
                size: 96,
                color: Utils.primaryColor,
              )
              : Text(
                Utils.formatSeconds(secs ~/ smoothener),
                style: const TextStyle(
                  color: Utils.textColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 64,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
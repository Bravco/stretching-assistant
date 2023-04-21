import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Data
import 'package:stretching_assistant/data/timer.dart';

// Page
import 'package:stretching_assistant/page/timer/settings.dart';

// Pub
import 'package:audioplayers/audioplayers.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({ Key? key }) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const int smoothener = 30;

  Timer? timer;
  bool isPaused = true;

  List<int> times = [];
  int currentLap = 0;
  late int lapsTemp;
  late int cooldownTimeTmp;
  late int stretchTimeTmp;
  late int relaxTimeTmp;
  late int maxSecs = cooldownTimeTmp;
  late int secs = cooldownTimeTmp;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ smoothener), (_) {
      if (!isPaused) {
        if (secs > 0 && currentLap != lapsTemp) {
          setState(() => secs--);
          if (secs == 0) {
            currentLap++;
            secs = times[currentLap];
            maxSecs = times[currentLap];

            AudioPlayer().play(AssetSource("alarm.mp3"));
          }
        }

        if (currentLap == lapsTemp) secs = 0;
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
      lapsTemp = laps * 2;
      cooldownTimeTmp = cooldownTime * smoothener;
      stretchTimeTmp = stretchTime * smoothener;
      relaxTimeTmp = relaxTime * smoothener;

      times = [];

      for (int i = 0; i < lapsTemp; i++) {
        if (i == 0) {
          times.add(cooldownTimeTmp);
        } else {
          if (i % 2 != 0) {
            times.add(stretchTimeTmp);
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
    if (currentLap < lapsTemp && currentLap + 1 != lapsTemp) {
      setState(() {
        currentLap++;
        secs = times[currentLap];
        maxSecs = times[currentLap];
      });
    } else if (currentLap + 1 == lapsTemp) {
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
    final bool isCompleted = currentLap == lapsTemp;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            buildTopBlock(),
            buildMiddleBlock(),
            Text(
              currentLap == 0
              ? "Get Ready"
              : currentLap == lapsTemp
                ? "Completed"
                : currentLap % 2 != 0
                  ? "Stretch"
                  : "Relax",
              style: TextStyle(
                color: currentLap % 2 != 0 || currentLap == lapsTemp
                  ? Utils.primaryColor
                  : Utils.textColorAlt,
                fontWeight: FontWeight.w300,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isCompleted
      ? FloatingActionButton(
        onPressed: () => restartTimer(),
        child: const Icon(Icons.done),
      )
      : FloatingActionButton(
        onPressed: () => toggleTimer(),
        child: !isPaused ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      "${currentLap ~/ 2}/$laps",
                      style: const TextStyle(
                        color: Utils.textColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 48,
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Text(
                      "stretch\nlaps",
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TimerSettingsPage(),
                          ),
                        ).then((value) => setupTimes());
                        restartTimer();
                      },
                      label: const Text("Settings"),
                      icon: const Icon(Icons.settings),
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
        buildTimer(),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: currentLap != lapsTemp
              ? () => nextLap()
              : null,
              icon: Icon(
                Icons.skip_next,
                size: 32,
                color: currentLap != lapsTemp
                ? Utils.textColor
                : Utils.textColorAlt,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerLeft,
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
              widget: currentLap == lapsTemp
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
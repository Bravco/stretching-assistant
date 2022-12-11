import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'dart:async';

//Data
import 'package:app/data/stretchings.dart';
import 'package:app/data/stretching.dart';

//Libaries
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//Widgets
import 'package:app/widget/appbar.dart';
import 'package:app/widget/outlined_button.dart';

class StretchingViewerPage extends StatefulWidget {
  final bool isCustom;
  final int stretchingIndex;

  const StretchingViewerPage({
    Key? key,
    this.isCustom = false,
    required this.stretchingIndex,
  }) : super(key: key);

  @override
  State<StretchingViewerPage> createState() => _StretchingViewerPageState();
}

class _StretchingViewerPageState extends State<StretchingViewerPage> {
  final itemController = ItemScrollController();
  final itemListener = ItemPositionsListener.create();

  Future scrollToItem(int item) async {
    if (currentLap % 2 != 0) itemController.jumpTo(index: item);
  }

  static const compressor = 30;
  List<int> times = [];
  int lapsTemp = laps * 2;
  int currentLap = 0;
  int workTemp = work * compressor;
  int restTemp = rest * compressor;
  int cooldownTemp = cooldown * compressor;
  late int maxSecs = cooldownTemp;
  late int secs = cooldownTemp;
  Timer? timer;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();

    audioPlayer.open(
      Audio("assets/alarm.mp3"),
      autoStart: false,
      showNotification: false,
    );

    for (int i = 0; i < lapsTemp; i++) {
      if (i == 0) times.add(cooldownTemp);
      if (i != 0 && i % 2 != 0) {
        times.add(workTemp);
      } else if (i != 0 && i % 2 == 0) {
        times.add(restTemp);
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  void resetTimer() {
    setState(() => timer?.cancel());

    setState(() {
      secs = times[0];
      maxSecs = times[0];
      currentLap = 0;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ compressor), (_) {
      if (secs > 0 && currentLap != lapsTemp) {
        setState(() => secs--);
        if (secs == 0) {
          currentLap++;
          secs = times[currentLap];
          maxSecs = times[currentLap];

          audioPlayer.play();
          scrollToItem((currentLap / 2).round() - 1);
        }
      }

      if (currentLap == lapsTemp) {
        secs = 0;
      }
    });
  }

  void stopTimer() {
    setState(() => timer?.cancel());
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

    scrollToItem((currentLap / 2).round() - 1);
  }

  void previousLap() {
    if (currentLap > 0) {
      setState(() {
        currentLap--;
        secs = times[currentLap];
        maxSecs = times[currentLap];
      });
    }

    scrollToItem((currentLap / 2).round() - 1);
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = currentLap == lapsTemp;

    return Scaffold(
      appBar: const AppBarPf(title: "Timer"),
      body: Center(
        child: Column(
          children: [
            buildTopBlock(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: currentLap != 0
                    ? () => previousLap()
                    : null,
                    icon: Icon(
                      Icons.skip_previous,
                      size: 32,
                      color: currentLap != 0
                      ? utils.color0
                      : utils.color0Alt,
                    ),
                  ),
                  currentLap % 2 != 0
                  ? Image(
                    image: widget.isCustom
                    ? AssetImage("assets/stretchings/karate/stretches/${customStretchings[widget.stretchingIndex].stretches[currentLap ~/ 2]}.png")
                    : AssetImage("assets/stretchings/${stretchings[widget.stretchingIndex].title}/stretches/${currentLap ~/ 2}.png"),
                    width: MediaQuery.of(context).size.width * .7,
                    height: MediaQuery.of(context).size.height * .2,
                  )
                  : const Icon(
                    Icons.self_improvement_rounded,
                    size: 147.5,
                    color: utils.color0Alt,
                  ),
                  IconButton(
                    onPressed: currentLap != lapsTemp
                    ? () => nextLap()
                    : null,
                    icon: Icon(
                      Icons.skip_next,
                      size: 32,
                      color: currentLap != lapsTemp
                      ? utils.color0
                      : utils.color0Alt,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
              color: utils.color0Alt,
              indent: 64,
              endIndent: 64,
            ),
            Expanded(
              child: ScrollablePositionedList.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: laps,
                itemScrollController: itemController,
                itemPositionsListener: itemListener,
                itemBuilder: (BuildContext context, int index) {
                  int stretchIndex = index + index + 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      decoration: stretchIndex == currentLap
                      ? BoxDecoration(
                        gradient: LinearGradient(
                          colors: const <Color>[
                            utils.color10Alt,
                            utils.color10Alt,
                            utils.color30,
                            utils.color30,
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
                      )
                      : stretchIndex < currentLap
                        ? const BoxDecoration(color: utils.color10Alt)
                        : const BoxDecoration(color: utils.color30),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              stretchIndex == currentLap
                              ? utils.formatTime(secs ~/ compressor)
                              : utils.formatTime(work),
                              style: const TextStyle(
                                color: utils.color0,
                                fontWeight: FontWeight.w300,
                                fontSize: 32,
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 2,
                              color: utils.color0Alt,
                              indent: 16,
                              endIndent: 16,
                            ),
                            Image(
                              image: widget.isCustom
                              ? AssetImage("assets/stretchings/karate/stretches/${customStretchings[widget.stretchingIndex].stretches[index]}.png")
                              : AssetImage("assets/stretchings/${stretchings[widget.stretchingIndex].title}/stretches/$index.png"),
                              fit: BoxFit.scaleDown,
                              width: MediaQuery.of(context).size.width * .4,
                              height: MediaQuery.of(context).size.height * .2,
                            ),
                            Icon(
                              stretchIndex < currentLap
                              ? Icons.check
                              : Icons.clear,
                              size: 40,
                              color: stretchIndex < currentLap
                              ? utils.color10
                              : utils.color0Alt,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isCompleted
      ? FloatingActionButton.small(
        onPressed: () => resetTimer(),
        backgroundColor: utils.color10,
        child: const Icon(Icons.done),
      )
      : FloatingActionButton.small(
        onPressed: () {
          if (isRunning) {
            stopTimer();
          } else {
            startTimer();
          }
        },
        backgroundColor: utils.color10,
        child: isRunning ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }

  Widget buildTopBlock() {
    final isCompleted = currentLap == lapsTemp ? true : false;

    return Column(
      children: [
        buildTimer(),
        Container(
          height: 128,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const <Color>[
                utils.color10Alt,
                utils.color10Alt,
                utils.color30,
                utils.color30,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              isCompleted
              ? const Icon(
                Icons.check,
                size: 72,
                color: utils.color10,
              )
              : Row(
                children: [
                  Text(
                    utils.formatTime(secs ~/ compressor),
                    style: const TextStyle(
                      color: utils.color0,
                      fontWeight: FontWeight.w300,
                      fontSize: 56,
                    ),
                  ),
                  const SizedBox(width: 12,),
                  const Text(
                    "Time\nremaining",
                    style: TextStyle(
                      color: utils.color0Alt,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              OutlinedButtonPf(
                voidCallback: () => resetTimer(),
                title: "Restart",
                iconData: Icons.restart_alt,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              currentLap % 2 != 0
              ? "Stretch."
              : "Relax.",
              style: const TextStyle(
                color: utils.color0,
                fontSize: 40,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTimer() {
    return LinearProgressIndicator(
      value: (maxSecs - secs) / (maxSecs / 1),
      valueColor: const AlwaysStoppedAnimation(utils.color10),
      backgroundColor: utils.color30,
      minHeight: 3,
    );
  }
}
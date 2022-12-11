import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Data
import 'package:app/data/stretchings.dart';
import 'package:app/data/stretching.dart';

//Widgets
import 'package:app/widget/appbar.dart';
import 'package:app/widget/stretchings/work_inputfield.dart';
import 'package:app/widget/stretchings/rest_inputfield.dart';

class StretchingSettingsPage extends StatefulWidget {
  final bool isCustom;
  final int stretchingIndex;
  final Function() notifyParent;

  const StretchingSettingsPage({
    Key? key,
    this.isCustom = false,
    required this.stretchingIndex,
    required this.notifyParent,
  }) : super(key: key);

  @override
  State<StretchingSettingsPage> createState() => _StretchingSettingsPageState();
}

class _StretchingSettingsPageState extends State<StretchingSettingsPage> {
  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarPf(title: "Settings"),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WorkInputfield(refresh: refresh),
              RestInputfield(refresh: refresh),
            ],
          ),
          const Divider(
            thickness: 2,
            color: utils.color0Alt,
            indent: 64,
            endIndent: 64,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: widget.isCustom
              ? customStretchings[widget.stretchingIndex].stretches.length
              : stretchings[widget.stretchingIndex].stretches,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    color: utils.color30,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            utils.formatTime(work),
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
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          widget.notifyParent();
        },
        backgroundColor: utils.color10,
        child: const Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Data
import 'package:app/data/timer.dart';

class LapsInputfield extends StatefulWidget {
  final Function() refresh;

  const LapsInputfield({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<LapsInputfield> createState() => _LapsInputfieldState();
}

class _LapsInputfieldState extends State<LapsInputfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children: [
          const Text(
            "work laps",
            style: TextStyle(
              color: utils.color0Alt,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.2,
            color: utils.color30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() {
                    laps != 1 ? laps-- : laps;
                    widget.refresh();
                  }),
                ),
                Text(
                  laps.toString(),
                  style: const TextStyle(
                    color: utils.color10,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  iconSize: 32,
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() {
                    laps != maxLaps ? laps++ : laps;
                    widget.refresh();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
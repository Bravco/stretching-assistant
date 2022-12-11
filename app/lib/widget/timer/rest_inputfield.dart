import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Data
import 'package:app/data/timer.dart';

class RestInputfield extends StatefulWidget {
  final Function() refresh;

  const RestInputfield({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<RestInputfield> createState() => _RestInputfieldState();
}

class _RestInputfieldState extends State<RestInputfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children: [
          const Text(
            "rest",
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
                    rest != 1 ? rest-- : rest;
                    widget.refresh();
                  }),
                ),
                Text(
                  utils.formatTime(rest),
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
                    rest != maxTime ? rest++ : rest;
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
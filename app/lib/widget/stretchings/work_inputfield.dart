import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

//Data
import 'package:app/data/stretching.dart';

class WorkInputfield extends StatefulWidget {
  final Function() refresh;

  const WorkInputfield({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<WorkInputfield> createState() => _WorkInputfieldState();
}

class _WorkInputfieldState extends State<WorkInputfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,),
      child: Column(
        children: [
          const Text(
            "work",
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
                    work != 1 ? work-- : work;
                    widget.refresh();
                  }),
                ),
                Text(
                  utils.formatTime(work),
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
                    work != maxTime ? work++ : work;
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
import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Pub
import 'package:holding_gesture/holding_gesture.dart';

class Inputfield extends StatelessWidget {
  final String? label;
  final bool? isTime;
  final int value;
  final void Function()? onIncrease;
  final void Function()? onDecrease;

  const Inputfield({
    this.label,
    this.isTime,
    required this.value,
    required this.onIncrease,
    required this.onDecrease,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          label != null ? Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              label as String,
              style: TextStyle(
                color: Utils.textColorAlt,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ) : Container(),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            color: Utils.secondaryBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HoldDetector(
                  onHold: onDecrease as void Function(),
                  holdTimeout: const Duration(milliseconds: 100),
                  behavior: HitTestBehavior.deferToChild,
                  enableHapticFeedback: true,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: onDecrease,
                    ),
                  ),
                ),
                Text(
                  isTime == true ? Utils.formatSeconds(value) : value.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                HoldDetector(
                  onHold: onIncrease as void Function(),
                  holdTimeout: const Duration(milliseconds: 100),
                  behavior: HitTestBehavior.deferToChild,
                  enableHapticFeedback: true,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: onIncrease,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

class TrainingPreview extends StatelessWidget {
  final Training training;
  final double width, height;
  final BorderRadiusGeometry? borderRadius;

  const TrainingPreview({
    super.key,
    required this.training,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    int duration = training.exercises.fold(0, (total, e) => total + e.value.inSeconds) ~/ 60;

    return Ink(
      width: width,
      height: training.image == null ? height / 1.2 : height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [Utils.boxShadow(Colors.black.withOpacity(.2))],
        color: training.image == null ? Utils.secondaryBackgroundColor : null,
        image: training.image != null ? DecorationImage(
          image: training.image!,
          fit: BoxFit.cover,
        ) : null,
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(.1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: training.image == null ? MainAxisAlignment.center : MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  training.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bolt,
                          color: Utils.primaryColor,
                        ),
                        Text(
                          "${training.exercises.length} ${training.exercises.length > 1 ? 'exercises' : 'exercise'}",
                          style: TextStyle(
                            color: Utils.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Utils.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "$duration ${duration == 1 ? 'minute' : 'minutes'}",
                          style: TextStyle(
                            color: Utils.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
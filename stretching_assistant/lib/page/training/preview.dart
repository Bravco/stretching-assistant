import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Widget
import 'package:stretching_assistant/widget/training_preview.dart';

// Page
import 'package:stretching_assistant/page/training/timer.dart';

class TrainingPage extends StatelessWidget {
  final Training training;

  const TrainingPage({
    super.key,
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TrainingPreview(
                training: training,
                width: MediaQuery.of(context).size.width,
                height: 160,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              ),

              for (int i = 0; i < training.exercises.length; i++) Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Utils.secondaryBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              training.exercises[i].key.name,
                              style: TextStyle(
                                color: Utils.textColorAlt,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              Utils.formatSeconds(training.exercises[i].value.inSeconds),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Image(
                          height: 96,
                          image: training.exercises[i].key.image,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TrainingTimerPage(training: training),
          )),
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
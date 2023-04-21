import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/trainings.dart';

// Widget
import 'package:stretching_assistant/widget/training_preview.dart';

// Page
import 'package:stretching_assistant/page/training.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: trainings.length,
        itemBuilder: (context, i) {
          Training training = trainings[i];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => TrainingPage(training: training)));
              },
              splashColor: Utils.primaryColorAlt,
              child: TrainingPreview(
                training: training,
                width: 320,
                height: 160,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';

// Data
import 'package:stretching_assistant/data/exercises.dart';

// Page
import 'package:stretching_assistant/page/training/add_exercise.dart';

class ExercisesPage extends StatelessWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: exercises.entries.map((entry) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddExercisePage(exercise: entry.value),
                )).then((value) {
                  if (value == null) return;
                  Navigator.of(context).pop(MapEntry<String, DurationHive>(
                    entry.key,
                    DurationHive.fromDuration(Duration(seconds: value)),
                  ));
                });
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: Utils.secondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.add),
                          const SizedBox(width: 16),
                          Text(
                            entry.value.name,
                            style: const TextStyle(
                              color: Utils.textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Image(
                        height: 96,
                        image: entry.value.image,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )).toList(),
        ),
      )
    );
  }
}
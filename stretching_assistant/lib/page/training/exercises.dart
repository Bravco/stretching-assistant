import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';

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
        body: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            Exercise exercise = exercises[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddExercisePage(exercise: exercise),
                  )).then((value) {
                    if (value == null) return;
                    Navigator.of(context).pop(MapEntry<Exercise, Duration>(exercise, Duration(seconds: value)));
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
                              exercise.name,
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
                          image: exercise.image,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      )
    );
  }
}
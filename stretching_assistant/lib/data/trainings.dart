import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/boxes.dart';
import 'package:stretching_assistant/data/exercises.dart';

List<Training> presetTrainings = [
  Training(
    name: "Full Body",
    image: const AssetImage("assets/fullbody.jpg"),
    exercises: [
      MapEntry(exercises[0], const Duration(seconds: 30)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 30)),
    ],
  ),
  Training(
    name: "Morning Routine",
    image: const AssetImage("assets/morning.jpg"),
    exercises: [
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
    ],
  ),
  Training(
    name: "Unlock Hamstrings",
    image: const AssetImage("assets/hamstrings.jpg"),
    exercises: [
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
    ],
  ),
];

Future<Training> addCustomTraining({required String name, List<MapEntry<Exercise, Duration>>? exercises}) async {
  final Training training = Training(
    name: name,
    exercises: exercises ?? [],
  );

  final box = Boxes.getCustomTrainings();
  box.add(training);

  return training;
}

void deleteCustomTraining(Training training) {
  training.delete();
}
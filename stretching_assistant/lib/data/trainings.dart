import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/boxes.dart';

final List<Training> presetTrainings = [
  Training(
    name: "Full Body",
    image: const AssetImage("assets/fullbody.jpg"),
    exercises: [
      MapEntry("Backbend Stretch", DurationHive(duration: 30)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 30)),
    ],
  ),
  Training(
    name: "Morning Routine",
    image: const AssetImage("assets/morning.jpg"),
    exercises: [
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
    ],
  ),
  Training(
    name: "Unlock Hamstrings",
    image: const AssetImage("assets/hamstrings.jpg"),
    exercises: [
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
      MapEntry("Backbend Stretch", DurationHive(duration: 60)),
    ],
  ),
];

Future<Training> addCustomTraining({required String name, List<MapEntry<String, DurationHive>>? exercises}) async {
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
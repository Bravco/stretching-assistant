import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/boxes.dart';

final List<Training> presetTrainings = [
  Training(
    name: "Hip Opener",
    image: const AssetImage("assets/splits.jpg"),
    exercises: [
      MapEntry("Horse Stance", DurationHive(duration: 45)),
      MapEntry("Butterfly Stretch", DurationHive(duration: 45)),
      MapEntry("Pancake Stretch", DurationHive(duration: 60)),
      MapEntry("Half Side Split Lean R", DurationHive(duration: 45)),
      MapEntry("Half Side Split Lean L", DurationHive(duration: 45)),
      MapEntry("Kozak Squat R", DurationHive(duration: 60)),
      MapEntry("Kozak Squat L", DurationHive(duration: 60)),
      MapEntry("Knee to Chest R", DurationHive(duration: 45)),
      MapEntry("Knee to Chest L", DurationHive(duration: 45)),
      MapEntry("Side Split R", DurationHive(duration: 90)),
      MapEntry("Side Split L", DurationHive(duration: 90)),
      MapEntry("Middle Split", DurationHive(duration: 90)),
    ],
  ),
  Training(
    name: "Unlock Hamstrings",
    image: const AssetImage("assets/hamstrings.jpg"),
    exercises: [
      MapEntry("Head to Knee R", DurationHive(duration: 45)),
      MapEntry("Head to Knee L", DurationHive(duration: 45)),
      MapEntry("Forward Stretch", DurationHive(duration: 60)), 
      MapEntry("Kozak Squat Lean R", DurationHive(duration: 45)),
      MapEntry("Kozak Squat Lean L", DurationHive(duration: 45)),
      MapEntry("Crossed Leg Head to Knee R", DurationHive(duration: 45)),
      MapEntry("Crossed Leg Head to Knee L", DurationHive(duration: 45)),
      MapEntry("Straight Leg Stretch R", DurationHive(duration: 60)),
      MapEntry("Straight Leg Stretch L", DurationHive(duration: 60)),
      MapEntry("Seated Foot to Head R", DurationHive(duration: 45)),
      MapEntry("Seated Foot to Head L", DurationHive(duration: 45)),
    ],
  ),
  Training(
    name: "Quads Lengthening",
    image: const AssetImage("assets/morning.jpg"),
    exercises: [
      MapEntry("Runner Lunge R", DurationHive(duration: 60)),
      MapEntry("Runner Lunge L", DurationHive(duration: 60)),
      MapEntry("Half Side Split R", DurationHive(duration: 60)),
      MapEntry("Half Side Split L", DurationHive(duration: 60)),
      MapEntry("Seated Quad Stretch", DurationHive(duration: 60)),
      MapEntry("Side Split R", DurationHive(duration: 90)),
      MapEntry("Side Split L", DurationHive(duration: 90)),
    ],
  ),
  Training(
    name: "Back Pain Relief",
    image: const AssetImage("assets/back.jpg"),
    exercises: [
      MapEntry("Supported Backbend Stretch", DurationHive(duration: 45)),
      MapEntry("Cobra Pose", DurationHive(duration: 60)),
      MapEntry("Seated Spinal Twist R", DurationHive(duration: 30)),
      MapEntry("Seated Spinal Twist L", DurationHive(duration: 30)),
      MapEntry("Lunge Backbend Stretch R", DurationHive(duration: 50)),
      MapEntry("Lunge Backbend Stretch L", DurationHive(duration: 50)),
      MapEntry("Seated Side Bend R", DurationHive(duration: 75)),
      MapEntry("Seated Side Bend L", DurationHive(duration: 75)),
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
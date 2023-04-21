import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

// Data
import 'package:stretching_assistant/data/exercises.dart';

List<Training> trainings = [
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
    name: "Morning",
    image: const AssetImage("assets/morning.jpg"),
    exercises: [
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
      MapEntry(exercises[0], const Duration(seconds: 60)),
    ],
  ),
  Training(
    name: "Hamstrings",
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
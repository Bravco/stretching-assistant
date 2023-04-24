import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';

class Training {
  final String name;
  final List<MapEntry<Exercise, Duration>> exercises;
  final ImageProvider? image;

  Training({
    required this.name,
    required this.exercises,
    this.image,
  });
}
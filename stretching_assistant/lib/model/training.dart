import 'package:flutter/material.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';

class Training {
  final String name;
  final ImageProvider image;
  final List<MapEntry<Exercise, Duration>> exercises;

  Training({
    required this.name,
    required this.image,
    required this.exercises,
  });
}
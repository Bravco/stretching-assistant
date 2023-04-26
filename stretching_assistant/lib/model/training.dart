import 'package:flutter/material.dart';

// Pub
import 'package:hive/hive.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';

part 'training.g.dart';

@HiveType(typeId: 0)
class Training extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<MapEntry<Exercise, Duration>> exercises;

  @HiveField(2)
  ImageProvider? image;

  Training({
    required this.name,
    required this.exercises,
    this.image,
  });
}

/*class Training {
  final String name;
  final List<MapEntry<Exercise, Duration>> exercises;
  final ImageProvider? image;

  Training({
    required this.name,
    required this.exercises,
    this.image,
  });
}*/
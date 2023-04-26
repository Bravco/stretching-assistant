import 'package:flutter/material.dart';

// Pub
import 'package:hive/hive.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';

part 'training.g.dart';

@HiveType(typeId: 1)
class Training extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<MapEntry<String, DurationHive>> exercises;

  @HiveField(2)
  ImageProvider? image;

  Training({
    required this.name,
    required this.exercises,
    this.image,
  });
}
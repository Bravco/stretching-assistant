import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Model
import 'package:stretching_assistant/model/exercise.dart';

late final Map<String, Exercise> exercises;

Future<Map<String, Exercise>> loadExercises() async {
  final assetBundle = rootBundle;
  final assetManifestJson = await assetBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> assetManifest = json.decode(assetManifestJson);

  final List<String> imagePaths = assetManifest.keys
      .where((String key) => key.startsWith('assets/exercises/'))
      .toList();

  final Map<String, Exercise> exercises = {};
  for (String imagePath in imagePaths) {
    final String imageName = imagePath.split('/').last.split('.').first;
    final AssetImage assetImage = AssetImage(imagePath);
    exercises[imageName] = Exercise(name: imageName, image: assetImage);
  }

  return exercises;
}
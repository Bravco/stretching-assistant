import 'package:flutter/material.dart';

// Pub
import 'package:hive/hive.dart';

// Model
import 'package:stretching_assistant/model/duration.dart';

class Exercise {
  final String name;
  final ImageProvider image;

  Exercise({
    required this.name,
    required this.image,
  });
}

class ExerciseEntryAdapter extends TypeAdapter<MapEntry<String, DurationHive>> {
  @override
  final int typeId = 2;

  @override
  MapEntry<String, DurationHive> read(BinaryReader reader) {
    final key = reader.readString();
    final value = DurationHive(duration: reader.readInt());
    return MapEntry(key, value);
  }

  @override
  void write(BinaryWriter writer, MapEntry<String, DurationHive> obj) {
    writer.writeString(obj.key);
    writer.writeInt(obj.value.duration);
  }
}
// Pub
import 'package:hive/hive.dart';

// Model
import 'package:stretching_assistant/model/training.dart';

class Boxes {
  static Box<Training> getCustomTrainings() => Hive.box<Training>("customTrainings");
}
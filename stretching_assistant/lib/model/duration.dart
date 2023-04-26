// Pub
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class DurationHive extends HiveObject {
  @HiveField(0)
  int duration;

  DurationHive({required this.duration});

  static DurationHive fromDuration(Duration duration) {
    return DurationHive(duration: duration.inSeconds);
  }

  Duration toDuration() {
    return Duration(seconds: duration);
  }
}

class DurationAdapter extends TypeAdapter<DurationHive> {
  @override
  final int typeId = 0;

  @override
  DurationHive read(BinaryReader reader) {
    final durationSeconds = reader.readInt();
    return DurationHive(duration: durationSeconds);
  }

  @override
  void write(BinaryWriter writer, DurationHive obj) {
    writer.writeInt(obj.duration);
  }
}
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'audio_model.g.dart';

@HiveType(typeId: 1)
class AudioModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final Uint8List? image;

  @HiveField(4)
  final String path;


  AudioModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.path,
  });
}

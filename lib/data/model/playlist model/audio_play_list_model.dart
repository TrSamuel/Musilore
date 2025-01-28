import 'package:hive_flutter/hive_flutter.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
part 'audio_play_list_model.g.dart';

@HiveType(typeId: 2)
class AudioPlayListModel {
  @HiveField(0)
  final String playListId;
  @HiveField(1)
  final String playListName;

  @HiveField(2)
  final List<AudioModel> audioModelList;

  AudioPlayListModel({
    required this.playListId,
    required this.playListName,
    required this.audioModelList, 
  });
}

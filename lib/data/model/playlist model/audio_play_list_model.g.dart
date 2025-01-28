// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_play_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioPlayListModelAdapter extends TypeAdapter<AudioPlayListModel> {
  @override
  final int typeId = 2;

  @override
  AudioPlayListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AudioPlayListModel(
      playListId: fields[0] as String,
      playListName: fields[1] as String,
      audioModelList: (fields[2] as List).cast<AudioModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, AudioPlayListModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.playListId)
      ..writeByte(1)
      ..write(obj.playListName)
      ..writeByte(2)
      ..write(obj.audioModelList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioPlayListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

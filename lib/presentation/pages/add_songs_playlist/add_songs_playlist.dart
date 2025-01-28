import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';

class AddSongsToPLayList extends StatefulWidget {
  final ThemeModel themeData;
  final List<AudioModel> audioModelList;
  final PlayListNotifier playListNotifierData;
  const AddSongsToPLayList(
      {super.key,
      required this.themeData,
      required this.audioModelList,
      required this.playListNotifierData});

  @override
  State<AddSongsToPLayList> createState() => _AddSongsToPLayListState();
}

class _AddSongsToPLayListState extends State<AddSongsToPLayList> {
  late List<AudioModel> songsList;

  @override
  void initState() {
    super.initState();
    songsList = List.from(widget.audioModelList);
  }

  @override
  Widget build(BuildContext context) {
    int songsCount = widget.audioModelList.length - songsList.length;
    return Scaffold(
      backgroundColor:
          widget.themeData.darkThemeStatus ? primaryColor : primaryTextColor,
      appBar: AppBar(
        backgroundColor:
            widget.themeData.darkThemeStatus ? primaryColor : primaryTextColor,
        foregroundColor:
            widget.themeData.darkThemeStatus ? primaryTextColor : primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: const Text("Select songs"),
        titleTextStyle: TextStyle(
          fontFamily: textFontFamilyName,
          fontSize: h2Size,
          color: widget.themeData.darkThemeStatus
              ? primaryTextColor
              : primaryColor,
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "$songsCount songs selected",
              style: TextStyle(
                color: widget.themeData.darkThemeStatus
                    ? primaryTextColor
                    : primaryColor,
                fontFamily: textFontFamilyName,
                fontSize: h3Size,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          )
        ],
      ),
      body: songsList.isEmpty
          ? Center(
              child: Text(
                'No songs available to add',
                style: TextStyle(
                  color: widget.themeData.darkThemeStatus
                      ? primaryTextColor
                      : primaryColor,
                  fontFamily: 'text-font',
                  fontSize: h3Size,
                ),
              ),
            )
          : ListView.builder(
              itemCount: songsList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: widget.themeData.darkThemeStatus
                      ? primaryColor
                      : primaryTextColor,
                  shadowColor: widget.themeData.secondaryColor,
                  shape: LinearBorder.bottom(
                      side: BorderSide(
                          style: BorderStyle.solid,
                          width: 0.5,
                          color: widget.themeData.secondaryColor)),
                  child: ListTile(
                    textColor: widget.themeData.darkThemeStatus
                        ? primaryTextColor
                        : primaryColor,
                    titleTextStyle: const TextStyle(
                      fontFamily: textFontFamilyName,
                      fontSize: h3Size,
                    ),
                    title: Text(
                      songsList[index].title,
                    ),
                    trailing: IconButton(
                        iconSize: 35,
                        color: widget.themeData.secondaryColor,
                        onPressed: () {
                          setState(() {
                            widget.playListNotifierData.addToSelectedSongs(
                                audioModel: songsList[index]);

                            songsList.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.add_circle)),
                  ),
                );
              },
            ),
    );
  }
}

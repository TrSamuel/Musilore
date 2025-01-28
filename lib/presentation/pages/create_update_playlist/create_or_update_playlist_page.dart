import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/pages/add_songs_playlist/add_songs_playlist.dart';
import 'package:musilore/presentation/pages/create_update_playlist/widgets/labelfor_createplaylist_form.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class CreateOrUpdatePLayListScreen extends StatelessWidget {
  final String? playListName;
  final String? playListId;
  final bool? isFavorites;
  const CreateOrUpdatePLayListScreen({
    super.key,
    this.playListName,
    this.playListId,
    this.isFavorites,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final playlistNameController = TextEditingController();
    if (playListName != null) {
      playlistNameController.text = playListName!;
    }
    return Consumer2<ThemeModel, PlayListNotifier>(
      builder: (context, themeData, playListNotifierData, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                playListName != null ? 'Edit playlist' : 'Create playlist'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            backgroundColor:
                themeData.darkThemeStatus ? primaryColor : primaryTextColor,
            foregroundColor:
                themeData.darkThemeStatus ? primaryTextColor : primaryColor,
          ),
          body: Container(
            color: themeData.darkThemeStatus ? primaryColor : primaryTextColor,
            width: double.infinity,
            height: double.infinity,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelForCreatePLaylistForm(
                        themeData: themeData,
                        lableName: 'Playlist name',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        readOnly: (isFavorites != null && isFavorites == true)
                            ? true
                            : false,
                        cursorColor: themeData.secondaryColor,
                        controller: playlistNameController,
                        style: TextStyle(
                          color: themeData.darkThemeStatus
                              ? primaryTextColor
                              : primaryColor,
                        ),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: themeData.darkThemeStatus
                                  ? themeData.secondaryColor
                                  : primaryColor.withOpacity(0.75)),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: themeData.secondaryColor,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: themeData.secondaryColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: themeData.secondaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: themeData.secondaryColor,
                            ),
                          ),
                        ),
                        validator: (value) {
                          value = value!.trim();
                          if (value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          formKey.currentState?.validate();
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      LabelForCreatePLaylistForm(
                        themeData: themeData,
                        lableName: 'Songs',
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: themeData.secondaryColor, width: 1)),
                        child: playListNotifierData.selectedSongsList.isEmpty
                            ? Center(
                                child: Text(
                                  playListName != null
                                      ? "No songs available"
                                      : 'No songs selected',
                                  style: TextStyle(
                                      fontFamily: textFontFamilyName,
                                      fontSize: h3Size,
                                      color: themeData.darkThemeStatus
                                          ? primaryTextColor
                                          : primaryColor),
                                ),
                              )
                            : ListView.builder(
                                itemCount: playListNotifierData
                                    .selectedSongsList.length,
                                itemBuilder: (context, index) {
                                  final orderedList = playListNotifierData
                                      .selectedSongsList.reversed
                                      .toList();
                                  return Card(
                                    color: themeData.darkThemeStatus
                                        ? primaryColor
                                        : primaryTextColor,
                                    shadowColor: themeData.secondaryColor,
                                    shape: LinearBorder.bottom(
                                        side: BorderSide(
                                            style: BorderStyle.solid,
                                            width: 0.5,
                                            color: themeData.secondaryColor)),
                                    child: ListTile(
                                      textColor: themeData.darkThemeStatus
                                          ? primaryTextColor
                                          : primaryColor,
                                      titleTextStyle: const TextStyle(
                                        fontFamily: textFontFamilyName,
                                        fontSize: h3Size,
                                      ),
                                      title: Text(
                                        orderedList[index].title,
                                      ),
                                      trailing: IconButton(
                                          color: themeData.secondaryColor,
                                          onPressed: () {
                                            playListNotifierData
                                                .removefromSelectedSongs(
                                              id: orderedList[index].id,
                                            );
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: themeData.secondaryColor,
                              foregroundColor: primaryColor,
                              fixedSize: Size.fromWidth(
                                  MediaQuery.sizeOf(context).width * 0.8)),
                          onPressed: () {
                            final songsList = Provider.of<SongNotifier>(context,
                                    listen: false)
                                .songsList;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddSongsToPLayList(
                                  themeData: themeData,
                                  audioModelList: songsList,
                                  playListNotifierData: playListNotifierData,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Add songs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: textFontFamilyName,
                                fontSize: h3Size,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: primaryColor,
                              backgroundColor: themeData.secondaryColor),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await DbFunctions.instance
                                  .createOrUpdatejPlayList(
                                    playListId: playListId,
                                    playListName: playlistNameController.text,
                                    listAudioModel:
                                        playListNotifierData.selectedSongsList,
                                  )
                                  .then(
                                    (_) => {
                                      if (playListId != null)
                                        {
                                          playListNotifierData
                                              .getCurrentSelectedPlayListSongs(
                                            playListId: playListId!,
                                          ),
                                        },
                                      snackbarWidget(
                                        text: playListId == null
                                            ? 'Playlist created'
                                            : 'Playlist updated',
                                        context: context,
                                        secondaryColor:
                                            themeData.secondaryColor,
                                      ),
                                      Provider.of<PlayListNotifier>(context,
                                              listen: false)
                                          .getPlayList(),
                                      Navigator.pop(context),
                                    },
                                  );
                            }
                          },
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 105),
                              child: Text(playListName != null
                                  ? 'Save changes'
                                  : 'Submit')),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

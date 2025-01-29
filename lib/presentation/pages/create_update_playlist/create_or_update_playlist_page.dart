import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/pages/add_songs_playlist/add_songs_playlist.dart';
import 'package:musilore/presentation/pages/create_update_playlist/widgets/add_songs_btn.dart';
import 'package:musilore/presentation/pages/create_update_playlist/widgets/labelfor_createplaylist_form.dart';
import 'package:musilore/presentation/pages/create_update_playlist/widgets/playlist_name_enterfiled.dart';
import 'package:musilore/presentation/pages/create_update_playlist/widgets/songs_selector.dart';
import 'package:musilore/presentation/pages/create_update_playlist/widgets/submit_btn.dart';
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
                      PlayListNameInputField(
                          themeData: themeData,
                          isFavorites: isFavorites,
                          playlistNameController: playlistNameController,
                          formKey: formKey),
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
                      SongsSelectorContainer(
                        playListNotifierData: playListNotifierData,
                        themeData: themeData,
                        playListName: playListName),
                      const SizedBox(
                        height: 15,
                      ),
                      AddSongsBtn(playListNotifierData: playListNotifierData,themeData: themeData),
                      const SizedBox(
                        height: 25,
                      ),
                      SubmitButton(
                        playListNotifierData: playListNotifierData,
                        themeData: themeData,
                          formKey: formKey,
                          playListId: playListId,
                          playlistNameController: playlistNameController,
                          playListName: playListName)
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




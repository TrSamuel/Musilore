import 'package:flutter/material.dart';
import 'package:musilore/core/utils/color/colors.dart';
import 'package:musilore/core/utils/size/size.dart';
import 'package:musilore/core/utils/text/txt.dart';
import 'package:musilore/data/model/audio%20model/audio_model.dart';
import 'package:musilore/data/sources/db_functions.dart';
import 'package:musilore/presentation/widgets/snack_bar.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

class CreateNewPLayListWIdget extends StatelessWidget {
  final ThemeModel themeData;
  const CreateNewPLayListWIdget({
    super.key,
    required this.secondaryColor,
    required this.themeData,
    required this.audioModel,
  });

  final Color secondaryColor;
  final AudioModel audioModel;

  @override
  Widget build(BuildContext context) {
    String playListName = '';
    final playListNotifier = Provider.of<PlayListNotifier>(context);
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: primaryTextColor,
                errorStyle: TextStyle(
                    color: themeData.darkThemeStatus
                        ? themeData.secondaryColor
                        : primaryColor.withOpacity(0.75)),
                enabledBorder: themeData.darkThemeStatus
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: themeData.darkThemeStatus
                              ? primaryColor
                              : secondaryColor,
                        ),
                      )
                    : InputBorder.none,
                focusedBorder: themeData.darkThemeStatus
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: primaryColor,
                        ),
                      )
                    : InputBorder.none,
                focusedErrorBorder: themeData.darkThemeStatus
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: primaryColor,
                        ),
                      )
                    : InputBorder.none,
                errorBorder: themeData.darkThemeStatus
                    ? const OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          width: 1,
                          color: primaryColor,
                        ),
                      )
                    : InputBorder.none,
                hintText: 'Enter playlist name'),
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (playlistname) {
              playListName = playlistname;
              formKey.currentState?.validate();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(
                  MediaQuery.sizeOf(context).width * 0.6,
                ),
                backgroundColor: themeData.darkThemeStatus
                    ? secondaryColor
                    : primaryTextColor.withOpacity(0.7),
                foregroundColor: primaryColor,
                textStyle: const TextStyle(
                  fontFamily: textFontFamilyName,
                  fontSize: h3Size,
                ),
              ),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await DbFunctions.instance.createOrUpdatejPlayList(
                    playListId: null,
                    playListName: playListName,
                    listAudioModel: [audioModel],
                  ).then(
                    (_) => {
                      Navigator.pop(context),
                      snackbarWidget(
                        text: 'Playlist created',
                        context: context,
                        secondaryColor: themeData.secondaryColor,
                      ),
                     playListNotifier
                          .getPlayList(),
                    },
                  );
                }
              },
              child: const Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}

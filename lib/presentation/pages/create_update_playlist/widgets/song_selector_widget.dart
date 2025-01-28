// import 'package:flutter/material.dart';
// import 'package:musilore/core/utils/color/colors.dart';
// import 'package:musilore/data/sources/db_functions.dart';
// import 'package:musilore/data/model/audio%20model/audio_model.dart';
// import 'package:musilore/state/notifier/play_list_notifier.dart';
// import 'package:musilore/state/notifier/theme_notifier.dart';

// class SongsSelecterWidget extends StatelessWidget {
//   final PlayListNotifier playListNotifierData;
//   final ThemeModel themeData;
//   const SongsSelecterWidget({
//     super.key,
//     required this.themeData,
//     required this.playListNotifierData,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: DbFunctions.instance.getSongsFromBox(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData || snapshot.hasError || snapshot.data!.isEmpty) {
//           return const Text("No songs available");
//         }
//         final List<AudioModel>? songList = snapshot.data;
//         return SizedBox(
//           width: double.infinity,
//           height: 300,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: songList!.length,
//             itemBuilder: (context, index) => CheckboxListTile(
//               fillColor: MaterialStatePropertyAll(themeData.secondaryColor),
//               checkColor: primaryColor,
//               title: Text(
//                 songList[index].title,
//                 style: TextStyle(
//                     color: themeData.darkThemeStatus
//                         ? primaryTextColor
//                         : primaryColor),
//               ),
//               value: playListNotifierData.selectedSongsIdList
//                   .contains(songList[index].id),
//               onChanged: (isChecked) {
//                 playListNotifierData.selectedSongsIdList
//                     .removeWhere((id) => id == songList[index].id);
//                 if (isChecked!) {
//                   playListNotifierData.addToSelectedSongs(
//                     id: songList[index].id,
//                   );
//                 } else {
//                   playListNotifierData.removefromSelectedSongs(
//                     id: songList[index].id,
//                   );
//                 }
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

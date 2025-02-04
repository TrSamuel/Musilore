import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musilore/presentation/pages/home/home_screen.dart';
import 'package:musilore/presentation/pages/now_play/play_screen.dart';
import 'package:musilore/presentation/pages/search/search_screen.dart';
import 'package:musilore/presentation/pages/splash/splash_page.dart';
import 'package:musilore/state/notifier/play_list_notifier.dart';
import 'package:musilore/state/notifier/search_notifier.dart';
import 'package:musilore/state/notifier/song_notifier.dart';
import 'package:musilore/state/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MusiLore());

  });
}

class MusiLore extends StatelessWidget {
  const MusiLore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SongNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchNotifer(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayListNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'splash-page': (context) => const SplashPage(),
          'home-page': (context) => const HomePage(),
          'search-page': (context) => const SearchScreen(),
          'play-song-page': (context) => const PlaySongPage(),
        },
        initialRoute: 'splash-page',
      ),
    );
  }
}

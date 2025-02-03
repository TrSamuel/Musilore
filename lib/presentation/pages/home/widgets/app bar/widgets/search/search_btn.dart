import 'package:flutter/material.dart';
import 'package:musilore/presentation/pages/home/widgets/app%20bar/app_bar_action_button.dart';
import 'package:musilore/state/notifier/search_notifier.dart';
import 'package:provider/provider.dart';

class SearchButtonWidget extends StatelessWidget {
  const SearchButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarActionButton(
      icon: Icons.search,
      action: () {
        Provider.of<SearchNotifer>(context, listen: false)
            .searchedSongsList
            .clear();
        Navigator.pushNamed(context, 'search-page');
      },
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:practice/src/pages/bottom_sheet.dart';
import 'package:practice/src/pages/bottom_sheet_statefull.dart';
import 'package:practice/src/pages/card_game.dart';
import 'package:practice/src/pages/chess.dart';
import 'package:practice/src/pages/home.dart';

class NavigatorBuilder extends StatefulWidget {
  const NavigatorBuilder({super.key, this.username});
  static const title = 'Home';
  static const homeIcon = Icon(CupertinoIcons.home);
  final String? username;

  @override
  State<NavigatorBuilder> createState() => _NavigatorBuilderState();
}

class _NavigatorBuilderState extends State<NavigatorBuilder> {
  final homeKey = GlobalKey();
  final cardKey = GlobalKey();
  final chessKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            label: HomePage.title,
            icon: HomePage.homeIcon,
          ),
          BottomNavigationBarItem(
            label: CardGame.title,
            icon: CardGame.homeIcon,
          ),
          BottomNavigationBarItem(
            label: ChessGame.title,
            icon: ChessGame.homeIcon,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        assert(index <= 2 && index >= 0, 'Unexpected tab index: $index');
        return switch (index) {
          0 => CupertinoTabView(
              defaultTitle: HomePage.title,
              builder: (context) => HomePage(
                key: homeKey,
                username: 'Long',
              ),
            ),
          1 => CupertinoTabView(
              defaultTitle: CardGame.title,
              builder: (context) => CardGame(),
            ),
          2 => CupertinoTabView(
              defaultTitle: ChessGame.title,
              builder: (context) => const ModalBottomSheetExample(),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}

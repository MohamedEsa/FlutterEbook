import 'package:bookchallange/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/book_model2.dart';
import '../screens/explorer_screen.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';

class ManageScreenToggle with ChangeNotifier {
  ManageScreenToggle();
  int currentIndex = 0;
  double containerHeight = 140.0;

  var isPressed = false;
  late CategoryFeed categoryFeed;

  List<Widget> screens = [HomeScreen(), ExplorerScreen(), FavouritesScreen()];

  late List<String> title = ['Flutter Ebook', 'Explorer', 'Favorites'];

  changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  changeContainerHeight() {
    isPressed = !isPressed;
    if (isPressed) {
      containerHeight = 300.0;
    } else {
      containerHeight = 140.0;
    }
    notifyListeners();
  }
}

import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/service/app_service.dart';
import 'package:flutter/cupertino.dart';

class ActionAdventureViewModel with ChangeNotifier {
  var _service = AppService();
  List<Entry> actionAdventure = [];
  var isLoadingActionAdventure = false;
  ActionAdventureViewModel() {
    getActionAdventureStory();
  }

  Future<void> getActionAdventureStory() async {
    try {
      isLoadingActionAdventure = true;
      notifyListeners();
      var catFeed = await _service.getActionAdventureStory();
      if (catFeed != null) {
        actionAdventure = catFeed.feed?.entry ?? [];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingActionAdventure = false;
      notifyListeners();
    }
  }
}

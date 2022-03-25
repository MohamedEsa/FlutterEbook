import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/service/app_service.dart';
import 'package:flutter/cupertino.dart';

class ShortStoryViewModel with ChangeNotifier {
  final _serivce = AppService();

  List<Entry> shortStorys = [];
  var isLoadingShortStory = false;

  ShortStoryViewModel() {
    getShortStory();
  }

  Future<void> getShortStory() async {
    try {
      isLoadingShortStory = true;
      notifyListeners();
      final catfeed = await _serivce.getShortStory();
      if (catfeed != null) {
        shortStorys = catfeed.feed?.entry ?? [];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingShortStory = false;
      notifyListeners();
    }
  }
}

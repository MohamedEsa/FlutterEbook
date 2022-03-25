import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/service/app_service.dart';
import 'package:flutter/foundation.dart';

class HomePageViewModel extends ChangeNotifier {
  final _service = AppService();
  List<Entry> popularBooks = [];
  List<Entry> recentBooks = [];
  List<String?> authorNames = [];
  var bookNames = [];
  var isLoadingRecent = false;
  var isLoadingPopular = false;

  void getRelated() async {
    var json = await _service.getPopular();
  }

  HomePageViewModel() {
    getPopular();
    getRecent();
  }

  Future<void> getPopular() async {
    try {
      isLoadingPopular = true;
      notifyListeners();

      final catFeed = await _service.getPopular();
      if (catFeed != null) {
        popularBooks = catFeed.feed?.entry ?? [];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingPopular = false;
      notifyListeners();
    }
  }

  Future<void> getRecent() async {
    try {
      isLoadingRecent = true;
      notifyListeners();

      final catFeed = await _service.getRecent();
      if (catFeed != null) {
        recentBooks = catFeed.feed?.entry ?? [];
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingRecent = false;
      notifyListeners();
    }
  }
}

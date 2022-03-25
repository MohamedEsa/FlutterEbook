import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/service/app_service.dart';
import 'package:flutter/cupertino.dart';

class CategoriesViewModel with ChangeNotifier {
  var _service = AppService();
  List<Entry> scienceFic = [];
  List<Entry> shortStories = [];
  List<Entry> action = [];
  var isloading = false;
  List<String?> authorNames = [];

  CategoriesViewModel() {
    getCategories();
  }

  Future<void> getCategories() async {
    isloading = true;
    final result = await Future.wait(
      [
        _service.getScienceFictionStory(),
        _service.getShortStory(),
        _service.getActionAdventureStory(),
      ],
    );
    scienceFic = result[0]?.feed?.entry ?? [];
    shortStories = result[1]?.feed?.entry ?? [];
    action = result[2]?.feed?.entry ?? [];
    isloading = false;
    notifyListeners();
  }
}

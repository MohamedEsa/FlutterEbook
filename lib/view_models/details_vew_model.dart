import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/service/app_service.dart';
import 'package:flutter/foundation.dart';

class DetailsViewlModel with ChangeNotifier {
  Entry? selectedBook;
  var _service = AppService();
  var isLoading = false;

  var relatedBooks = <Entry>[];

  getFeed() async {
    if (selectedBook == null) {
      return;
    }
    try {
      relatedBooks.clear();
      setLoading(true);
      var feed = await _service.getCategoryFeed(
          selectedBook!.author!.uri!.t!.replaceAll(r'\&lang=en', ''));
      setRelated(feed);
    } catch (e) {
      throw (e);
    } finally {
      setLoading(false);
    }
  }

  void setRelated(CategoryFeed? value) {
    if (value != null) {
      relatedBooks = value.feed?.entry ?? [];
    }
    notifyListeners();
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}

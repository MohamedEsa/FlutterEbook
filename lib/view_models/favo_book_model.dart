import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/book_model2.dart';
import '../shared/network/local/shared_pref.dart';

class FavorViewlModel with ChangeNotifier {
  FavorViewlModel() {
    getFavouriteList();
  }
  var _favouriteList = <Entry>[];

  List<Entry> get favouriteList => _favouriteList;

  Future<void> getFavouriteList() async {
    final jsonBody = await CacheHelper.getData(FavKey);
    if (jsonBody != null) {
      final favList = json.decode(jsonBody) as List;
      _favouriteList = List.from(
        favList.map((b) => Entry.fromJson(b)),
      );
    }
    notifyListeners();
  }

  void addToFavourite(Entry book) {
    // add book to list
    _favouriteList.add(book);

    // save new list to local
    final list = [];
    _favouriteList.forEach((b) {
      list.add(b.toJson());
    });
    CacheHelper.saveData(
      FavKey,
      json.encode(list),
    );
    notifyListeners();
  }

  void deleteFromFavourite(Entry book) {
    _favouriteList.remove(book);

    CacheHelper.saveData(
      FavKey,
      json.encode(_favouriteList.map((b) => b.toJson()).toList()),
    );
    notifyListeners();
  }

  void toggleFav(Entry book) {
    if (_favouriteList.contains(book)) {
      deleteFromFavourite(book);
    } else {
      addToFavourite(book);
    }
  }

  bool checkFav(Entry book) => _favouriteList.contains(book);
}

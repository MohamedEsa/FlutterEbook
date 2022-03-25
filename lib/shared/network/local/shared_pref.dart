import 'dart:convert';

import 'package:bookchallange/models/book_model2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const FavKey = 'favourites';

class CacheHelper {
  static late SharedPreferences sharedPreferences;
  static List<String>? favBooks = [];
  static List<String>? favBooksName = [];
  static List<Entry> bookList = [];
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getBookImage({required String key}) {
    favBooks = sharedPreferences.getStringList(key);
    return favBooks;
  }

  static dynamic getBookName({required String key}) {
    favBooksName = sharedPreferences.getStringList(key);
    return favBooksName;
  }

  static dynamic getBookList({required String key}) {
    Map<String, dynamic> json = jsonDecode(sharedPreferences.getString(key)!);
    bookList.add(Entry.fromJson(json));
    // bookList.add(Entry.fromJson(json));
    return bookList;
  }

  static Future<String?> getData(
    String key,
  ) async {
    return sharedPreferences.getString(key);
  }

  static Future<bool> saveData(String key, String value) async {
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}

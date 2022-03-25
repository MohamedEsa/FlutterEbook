import 'dart:convert';

import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/remote/api_routes.dart';
import 'package:bookchallange/shared/network/remote/dio.dart';
import 'package:xml2json/xml2json.dart';

class AppService {
  Future<CategoryFeed?> getCategoryFeed(String url) async {
    try {
      final response = await DioHelper.getData(url: url);
      if (response.statusCode == 200) {
        // to convert from xml to json format
        final myTransformer = Xml2Json();
        var xmlData = response.data;
        myTransformer.parse(xmlData.toString());
        var json = jsonDecode(myTransformer.toGData());
        final categoryFeed = CategoryFeed.fromJson(json);
        return categoryFeed;
      } else {
        throw 'Erorr';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CategoryFeed?> getPopular() async {
    return getCategoryFeed(ApiRoutes.popular);
  }

  Future<CategoryFeed?> getRecent() async {
    return getCategoryFeed(ApiRoutes.recent);
  }

  Future<CategoryFeed?> getShortStory() async {
    return getCategoryFeed(ApiRoutes.shortStory);
  }

  Future<CategoryFeed?> getScienceFictionStory() async {
    return getCategoryFeed(ApiRoutes.sciFi);
  }

  Future<CategoryFeed?> getActionAdventureStory() async {
    return getCategoryFeed(ApiRoutes.actionAdventure);
  }

  Future<CategoryFeed?> getNoteworthy() async {
    return getCategoryFeed(ApiRoutes.noteworthy);
  }
}

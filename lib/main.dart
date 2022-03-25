import 'dart:io';
import 'dart:math';

import 'package:bookchallange/layout/book_layout.dart';
import 'package:bookchallange/provider/provider.dart';
import 'package:bookchallange/shared/network/local/shared_pref.dart';
import 'package:bookchallange/shared/network/remote/dio.dart';
import 'package:bookchallange/view_models/ActionAdventure_view_model.dart';
import 'package:bookchallange/view_models/ScienceFiction_view_model.dart';
import 'package:bookchallange/view_models/details_vew_model.dart';
import 'package:bookchallange/view_models/download_book_view_model.dart';
import 'package:bookchallange/view_models/favo_book_model.dart';
import 'package:bookchallange/view_models/home_page_view_model.dart';
import 'package:bookchallange/view_models/short_stories_view_model.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  await Firebase.initializeApp();

  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomePageViewModel>(
          create: (context) => HomePageViewModel(),
        ),
        ChangeNotifierProvider<ManageScreenToggle>(
          create: (context) => ManageScreenToggle(),
        ),
        ChangeNotifierProvider<ShortStoryViewModel>(
          create: (context) => ShortStoryViewModel(),
        ),
        ChangeNotifierProvider<CategoriesViewModel>(
          create: (context) => CategoriesViewModel(),
        ),
        ChangeNotifierProvider<ActionAdventureViewModel>(
          create: (context) => ActionAdventureViewModel(),
        ),
        ChangeNotifierProvider<DetailsViewlModel>(
          create: (context) => DetailsViewlModel(),
        ),
        ChangeNotifierProvider<FavorViewlModel>(
          create: (context) => FavorViewlModel(),
        ),
        ChangeNotifierProvider<DownloadViewlModel>(
          create: (context) => DownloadViewlModel(),
        ),
      ],
      child: MaterialApp(
        home: BookLayout(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

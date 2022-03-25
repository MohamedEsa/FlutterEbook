import 'dart:io';

import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/network/remote/dio.dart';
import 'package:bookchallange/shared/network/service/app_service.dart';
import 'package:dio/dio.dart';
import 'package:epub_viewer/epub_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadViewlModel with ChangeNotifier {
  bool isLoading = false;
  bool isDownlaoded = false;
  double progress = 0.0;
  String partOfBookPath = '';

  Future<bool> saveBook(String url, String fileName) async {
    Directory? directory;
    try {
      if (await _reruestGranted(Permission.storage)) {
        //  directory = await getExternalStorageDirectory();
        directory = await getExternalStorageDirectory();
        print(directory?.path);
        String newPath = '';
        List<String> folders = directory!.path.split('/');
        for (int x = 1; x < folders.length; x++) {
          String folder = folders[x];
          if (folder != 'Android') {
            newPath += '/' + folder;
          } else {
            break;
          }
        }
        newPath = newPath + '/booksFolder';
        partOfBookPath = newPath;
        directory = Directory(newPath);
        print(directory.path);
      } else {
        return false;
      }
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        File saveFile = File(directory.path + '/$fileName');

        await DioHelper.dio.download(url, saveFile.path,
            onReceiveProgress: (downloaded, totalSize) {
          progress = downloaded / totalSize;
          notifyListeners();
        }).then((value) {
          isDownlaoded = true;
          print('fileDownloaded');
        });
      }
    } catch (e) {}

    notifyListeners();
    return false;
  }

  Future<bool> _reruestGranted(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void readBook(String bookName) async {
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // print('$appDocDir');
    String androidBookPath = '$partOfBookPath/$bookName.epub';
    bool fileExists = await File(androidBookPath).exists();
    print(androidBookPath);
    if (fileExists) {
      EpubViewer.setConfig(
          themeColor: Colors.white,
          identifier: "AndroidBook",
          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
          allowSharing: true,
          enableTts: true,
          nightMode: false);
      EpubViewer.open(androidBookPath);
    }

    notifyListeners();
  }

  void checkFileExits(String bookName) async {
    String androidBookPath = '$partOfBookPath/$bookName.epub';
    bool fileExists = await File(androidBookPath).exists();

    if (fileExists) {
      isDownlaoded = true;
    } else {
      isDownlaoded = false;
    }
    notifyListeners();
  }
}

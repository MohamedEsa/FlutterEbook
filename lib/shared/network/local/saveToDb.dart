import 'dart:io';
import 'package:bookchallange/models/book_model2.dart';
import 'package:objectdb/src/objectdb_storage_filesystem.dart';

import 'package:objectdb/objectdb.dart';

class SaveToDb {
  List<Entry> book = [];
  void saveTodb() async {
    final path = Directory.current.path + '/my.db';

// create database instance and open
    final db = ObjectDB(FileSystemStorage(path));

// remove documents
    db.remove({'active': false});

// search documents in database
    var result = await db.find({'active': true, 'name.first': 'Some'});

// cleanup the db file
    db.cleanup();

// close db
    await db.close();
  }
}

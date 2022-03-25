import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/provider/provider.dart';
import 'package:bookchallange/shared/components/componants.dart';
import 'package:bookchallange/shared/network/local/shared_pref.dart';
import 'package:bookchallange/view_models/ScienceFiction_view_model.dart';
import 'package:bookchallange/view_models/details_vew_model.dart';
import 'package:bookchallange/view_models/favo_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

import 'book_description_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // List<String> imageList = CacheHelper.getBookImage(key: 'favKey');
  // List<String> nameList = CacheHelper.getBookName(key: 'favKeyName');
  // List<Entry> bookList=[];
  // Entry? bookList;
  @override
  void initState() {
    // CacheHelper.getData(key: 'favBook');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
      ),
      body: Consumer<FavorViewlModel>(builder: (context, model, _) {
        return model.favouriteList.isEmpty
            ? Center(
                child: Text('Add your favourite books'),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildFavItem(
                          index: index,
                          //  imagelist: imageList,
                          // namelist: nameList,
                          context: context,
                          book: model.favouriteList),
                      itemCount: model.favouriteList.length,
                    )),
              );
      }),
    );
  }
}

Widget buildFavItem(
        {
        //List<String>? imagelist,
        required int index,
        // List<String>? namelist,
        required BuildContext context,
        List<Entry>? book}) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDescription(
                      book: book![index],
                    )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: 140.0,
            clipBehavior: Clip.none,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage('${book?[index].link?[1].href}'),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            width: 140.0,
            child: Text(
              '${book?[index].title?.t}',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );

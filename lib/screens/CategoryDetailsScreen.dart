import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/shared/components/componants.dart';
import 'package:bookchallange/view_models/short_stories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_description_screen.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final List<Entry> bookList;
  final String title;

  const CategoryDetailsScreen({required this.bookList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ),
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
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDescription(
                            book: bookList[index],
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          child: buildListItem(
                              index: index,
                              model: bookList[index].link?[1].href),
                          height: 150.0,
                          width: 100,
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${bookList[index].title?.t}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${bookList[index].author?.name?.t}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.lightBlue),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                '${bookList[index].summary?.t}',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 14.0),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 20.0,
                  ),
              itemCount: bookList.length)),
    );
  }
}

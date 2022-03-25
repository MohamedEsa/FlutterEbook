import 'package:bookchallange/shared/components/componants.dart';
import 'package:bookchallange/view_models/ActionAdventure_view_model.dart';
import 'package:bookchallange/view_models/ScienceFiction_view_model.dart';
import 'package:bookchallange/view_models/short_stories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import 'Action_Adventure_screen.dart';
import 'Science_Fiction_screen.dart';
import 'book_description_screen.dart';
import 'CategoryDetailsScreen.dart';

class ExplorerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesViewModel>(builder: (context, cat, _) {
      return cat.isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Short Stories',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryDetailsScreen(
                                              bookList: cat.shortStories,
                                              title: 'Short Stories',
                                            )));
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(color: Colors.lightBlue),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            child: buildListItem(
                              index: index,
                              model: cat.shortStories[index].link?[1].href,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDescription(
                                    book: cat.shortStories[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 15.0,
                          ),
                          itemCount: cat.shortStories.length,
                        ),
                        height: 200.0,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Science Fiction ',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryDetailsScreen(
                                              bookList: cat.scienceFic,
                                              title: 'Science Fiction',
                                            )));
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(color: Colors.lightBlue),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            child: buildListItem(
                              index: index,
                              model: cat.scienceFic[index].link?[1].href,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDescription(
                                    book: cat.scienceFic[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 15.0,
                          ),
                          itemCount: cat.scienceFic.length,
                        ),
                        height: 200.0,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Action & Adventure ',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CategoryDetailsScreen(
                                              bookList: cat.action,
                                              title: 'Action & Adventure',
                                            )));
                              },
                              child: Text(
                                'See All',
                                style: TextStyle(color: Colors.lightBlue),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => InkWell(
                            child: buildListItem(
                              index: index,
                              model: cat.action[index].link?[1].href,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDescription(
                                    book: cat.action[index],
                                  ),
                                ),
                              );
                            },
                          ),
                          separatorBuilder: (context, index) => SizedBox(
                            width: 15.0,
                          ),
                          itemCount: cat.action.length,
                        ),
                        height: 200.0,
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}

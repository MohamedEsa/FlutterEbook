import 'package:bookchallange/view_models/ScienceFiction_view_model.dart';
import 'package:bookchallange/view_models/home_page_view_model.dart';

import '../models/book_model2.dart';

import '../provider/provider.dart';
import 'CategoryDetailsScreen.dart';
import '../shared/components/componants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Action_Adventure_screen.dart';
import 'Science_Fiction_screen.dart';
import 'book_description_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageViewModel>(builder: (context, model, _) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => InkWell(
                      child: buildListItem(
                        index: index,
                        model: model.popularBooks[index].link?[1].href,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDescription(
                              book: model.popularBooks[index],
                            ),
                          ),
                        );
                      }),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 15.0,
                  ),
                  itemCount: model.popularBooks.length,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Container(
                  height: 30.0,
                  child: Consumer<CategoriesViewModel>(
                    builder: (context, model, _) {
                      return model.isloading
                          ? LinearProgressIndicator()
                          : ListView(
                              // اوعى بقى
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                    height: 30.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.blueAccent),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryDetailsScreen(
                                                      bookList:
                                                          model.shortStories,
                                                      title: 'Short Stories',
                                                    )));
                                      },
                                      child: Center(
                                          child: Text(
                                        'Short Stories',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                    height: 30.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.blueAccent),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ScienceFictionScreen()));
                                      },
                                      child: Center(
                                          child: Text(
                                        'Science Fiction',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Container(
                                    height: 30.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.blueAccent),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ActionAdventureScreen()));
                                      },
                                      child: Center(
                                          child: Text(
                                        'Action & Adventure',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    )),
                                SizedBox(
                                  width: 10.0,
                                ),
                              ],
                            );
                    },
                  )),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Recently Added',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              //vertical List
              ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookDescription(
                                        book: model.recentBooks[index],
                                      )));
                        },
                        child: Row(
                          children: [
                            Container(
                              child: buildListItem(
                                  index: index,
                                  model:
                                      model.recentBooks[index].link?[1].href),
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
                                    '${model.recentBooks[index].title?.t}',
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
                                    '${model.recentBooks[index].author?.name?.t}',
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
                                    '${model.recentBooks[index].summary?.t}',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14.0),
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
                  itemCount: model.recentBooks.length)
            ],
          ),
        ),
      );
    });
  }
}

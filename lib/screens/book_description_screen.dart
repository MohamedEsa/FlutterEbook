import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/provider/provider.dart';
import 'package:bookchallange/shared/components/componants.dart';
import 'package:bookchallange/shared/network/local/shared_pref.dart';
import 'package:bookchallange/view_models/ScienceFiction_view_model.dart';
import 'package:bookchallange/view_models/details_vew_model.dart';
import 'package:bookchallange/view_models/download_book_view_model.dart';
import 'package:bookchallange/view_models/favo_book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookDescription extends StatefulWidget {
  final Entry book;
  BookDescription({
    required this.book,
  });

  @override
  _BookDescriptionState createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  bool showAll = false;
  bool isPressed = false;
  // static List<String>? favBooks = [];
  // static List<String>? favBooksName = [];

  @override
  void initState() {
    getRelated();
    Provider.of<DownloadViewlModel>(context, listen: false)
        .checkFileExits(widget.book.title!.t!);

    super.initState();
  }

  getRelated() {
    final detailsModel = Provider.of<DetailsViewlModel>(context, listen: false);
    detailsModel.selectedBook = widget.book;
    detailsModel.getFeed();
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
          Consumer<FavorViewlModel>(builder: (context, model, _) {
            final isFav = model.checkFav(widget.book);
            return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border_outlined,
                  color: isFav ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  model.toggleFav(widget.book);
                });
          }),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 200.0,
                    width: 140.0,
                    clipBehavior: Clip.none,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage('${widget.book.link?[1].href}'),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title?.t ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.book.author?.name?.t ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 30.0,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10.0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.book.category?.length ?? 0,
                            itemBuilder: (context, index) => Container(
                              height: 30.0,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white),
                              child: MaterialButton(
                                onPressed: () {},
                                child: Center(
                                  child: Text(
                                    widget.book.category?[index].label ?? '',
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Consumer<DownloadViewlModel>(
                            builder: (context, model, _) {
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                model.isDownlaoded
                                    ? TextButton(
                                        child: Text(
                                          'ReadBook',
                                          style: TextStyle(),
                                        ),
                                        onPressed: () {
                                          model.readBook(widget.book.title!.t!);
                                        },
                                      )
                                    : TextButton(
                                        child: Text(
                                          'Download',
                                          style: TextStyle(),
                                        ),
                                        onPressed: () {
                                          model.saveBook(
                                              widget.book.link![3].href!,
                                              '${widget.book.title!.t}.epub');
                                          isPressed = true;
                                        },
                                      )
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),

              Consumer<DownloadViewlModel>(
                  builder: (context, model, _) => isPressed
                      ? LinearProgressIndicator(
                          value: model.progress,
                          backgroundColor: Colors.white,
                          color: Colors.grey,
                        )
                      : SizedBox()),

              SizedBox(
                height: 30.0,
              ),
              Text(
                'Book Description',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold),
              ),
              mySeparator(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                ' ${widget.book.summary?.t}',
                maxLines: showAll ? 100 : 6,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      showAll = !showAll;
                    });
                  },
                  child: Text(
                    showAll ? 'Show less' : 'Show all',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'More From Author',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold),
              ),
              mySeparator(),
              //vertical List

              Consumer<DetailsViewlModel>(builder: (context, model, _) {
                return model.isLoading
                    ? SizedBox()
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return BookDescription(
                                    book: model.relatedBooks[index],
                                  );
                                }));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    child: buildListItem(
                                        index: index,
                                        model: model
                                            .relatedBooks[index].link?[1].href),
                                    height: 150.0,
                                    width: 100,
                                  ),
                                  SizedBox(
                                    width: 15.0,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${model.relatedBooks[index].title?.t}',
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
                                        '${model.relatedBooks[index].author?.name?.t}',
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
                                        '${model.relatedBooks[index].summary?.t}',
                                        style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 14.0),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 20.0,
                            ),
                        itemCount: model.relatedBooks.length);
              })
            ],
          ),
        ),
      ),
    );
  }
}

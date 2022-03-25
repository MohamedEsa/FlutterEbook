import 'package:bookchallange/models/book_model2.dart';
import 'package:bookchallange/screens/book_description_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildListItem(
        {Clip? clip = Clip.antiAlias, model, required int index}) =>
    Container(
      height: 200.0,
      width: 130.0,
      clipBehavior: clip!,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Image(
        fit: BoxFit.cover,
        image: NetworkImage('${model}'),
      ),
    );
Widget verticalList() => ListView.separated(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                child: buildListItem(index: index),
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
                      'The Double',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'fyodor Mikhailovich Dostoyevsky',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.lightBlue),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      ' ake a type specimen book ake a type specimen book '
                      ' ake a type specimen book ake a type specimen book  '
                      ' ake a type specimen book ake a type specimen book  ',
                      style: TextStyle(color: Colors.grey[500], fontSize: 14.0),
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
    itemCount: 5);

Widget horizontalList(model) => ListView.separated(
    physics: BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) => InkWell(
          child: buildListItem(index: index, model: model),
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => BookDescription(index: index, model1: model,model2: model,)));
          },
        ),
    separatorBuilder: (context, index) => SizedBox(
          width: 15.0,
        ),
    itemCount: 40);
Widget mySeparator() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

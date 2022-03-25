import 'package:bookchallange/screens/favourite_screen.dart';
import 'package:bookchallange/view_models/download_book_view_model.dart';
import 'package:bookchallange/view_models/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/components/componants.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    size: 30.0,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),
                  Text(
                    'Favorites',
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

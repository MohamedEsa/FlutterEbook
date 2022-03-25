import 'package:bookchallange/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookLayout extends StatelessWidget {
  const BookLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ManageScreenToggle>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Center(
          child: Text(
            '${provider.title[provider.currentIndex]}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: provider.screens[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          Provider.of<ManageScreenToggle>(context, listen: false)
              .changeIndex(index);
        },
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.home_outlined)),
          BottomNavigationBarItem(
              label: 'Explorer', icon: Icon(Icons.explore_outlined)),
          BottomNavigationBarItem(
              label: 'Favourites', icon: Icon(Icons.favorite_outline_outlined))
        ],
      ),
    );
  }
}

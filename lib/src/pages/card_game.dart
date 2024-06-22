import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardGame extends StatefulWidget {
  CardGame({super.key});
  static const title = 'Card Game';
  static const homeIcon = Icon(CupertinoIcons.gamecontroller);

  @override
  State<CardGame> createState() => _CardGameState();
  void callBack(int index, Card card) {}
}

class _CardGameState extends State<CardGame> {
  final cardKey = GlobalKey();
  int point = 0;
  String? lastValue;
  int? lastIndex;
  List<Card> items = [
    Card(1, 'Cat', 'Cat', false, 'assets/images/cat.jpg'),
    Card(2, 'Dog', 'Dog', false, 'assets/images/dog.jpg'),
    Card(3, 'Pig', 'Pig', false, 'assets/images/pig.jpg'),
    Card(4, 'Cow', 'Cow', false, 'assets/images/cow.png'),
    Card(5, 'Mouse', 'Mouse', false, 'assets/images/mouse.jpg'),
    Card(6, 'Cat', 'Cat', false, 'assets/images/cat.jpg'),
    Card(7, 'Dog', 'Dog', false, 'assets/images/dog.jpg'),
    Card(8, 'Pig', 'Pig', false, 'assets/images/pig.jpg'),
    Card(9, 'Cow', 'Cow', false, 'assets/images/cow.png'),
    Card(10, 'Mouse', 'Mouse', false, 'assets/images/mouse.jpg'),
    Card(11, 'Tiger', 'Tiger', false, 'assets/images/Tiger.jpeg'),
    Card(12, 'Tiger', 'Tiger', false, 'assets/images/Tiger.jpeg'),
  ]; // Replace with your actual list data type

  checkCard(int idx, Card item) {
    if (item.isOpened) return;
    items[idx].isOpened = true;
    if (lastValue == null) {
      lastIndex = idx;
      lastValue = item.value;
    } else {
      if (item.value == lastValue) {
        point++;
      } else {
        var timer = Timer(Duration(seconds: 1), () => {});
        items[lastIndex!].isOpened = false;
        items[idx].isOpened = false;

        timer.cancel();
      }
      lastIndex = null;
      lastValue = null;
    }
    widget.callBack(idx, item);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Card Game'),
        previousPageTitle: '',
      ),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(children: [
      SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text("Score: " + point.toString()),
                ElevatedButton(
                  onPressed: () => {
                    setState(() {
                      items.forEach((itm) => {itm.isOpened = false});
                      items[1].isOpened = false;
                      items.shuffle();
                      point = 0;
                    })
                  },
                  child: Text('Reset'),
                ),
              ],
            ),
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(16.0),
              crossAxisCount: 3, // Two columns
              children: items
                  .asMap()
                  .entries
                  .map((item) => _buildItem(item))
                  .toList(),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _buildItem(MapEntry<int, Card> item) {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (item.value.isOpened) return;
            items[item.key].isOpened = true;
            if (lastValue == null) {
              lastIndex = item.key;
              lastValue = item.value.value;
            } else {
              if (item.value.value == lastValue) {
                point++;
              } else {
                var timer = Timer(Duration(seconds: 1), () => {});
                items[lastIndex!].isOpened = false;
                items[item.key].isOpened = false;

                timer.cancel();
              }
              lastIndex = null;
              lastValue = null;
            }
            widget.callBack(item.key, item.value);
          });
        },
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(10.0), // Add padding for content
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(5.0), // Rounded corners
              image: DecorationImage(
                  image: AssetImage(item.value.isOpened
                      ? item.value.img
                      : 'assets/images/card.jpg'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Text(
              item.value.isOpened ? item.value.name : '?',
              style: TextStyle(
                  fontSize: 16.0, color: Colors.black), // Adjust text style
            ),
          ),
        ));
  }
}

class Card {
  int id;
  String name;
  String value;
  bool isOpened;
  String img;
  Card(this.id, this.name, this.value, this.isOpened, this.img);
}

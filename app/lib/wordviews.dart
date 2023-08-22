
import 'dart:js_util';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_master/main.dart';
import 'word.dart';
class WordViews extends StatefulWidget {
  const WordViews({super.key});
  @override
  State<WordViews> createState() => _WordViewsState();
}

class _WordViewsState extends State<WordViews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${Keys.length}"),
      ),
      body: ListView.builder(itemCount: word.length*2,itemBuilder: (context,index){
        var realIndex = index ~/ 2;
        var Chapter = (realIndex) ~/ 50;
        if(index.isOdd) return Divider();
        return ListTile(title: Row(
          children: [
            TEXT1(Keys[realIndex], FontWeight.bold, 20),
            TEXT1(word[Keys[realIndex]]!, FontWeight.bold, 20),
          ],)
          ,subtitle: TEXT1("${Chapter},${realIndex}",FontWeight.w400,15)
          );
      }
      )
    );
  }
}

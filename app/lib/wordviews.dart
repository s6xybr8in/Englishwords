import 'package:flutter/material.dart';
import 'main.dart';
import 'word.dart';
class WordViews extends StatefulWidget {
  WordViews({required this.chapter, super.key});
  final int chapter;
  @override
  State<WordViews> createState() => _WordViewsState(chapter);
}

class _WordViewsState extends State<WordViews> {
  final int chapter;
  var count = 0;
  List<bool> checked = [];
  _WordViewsState(this.chapter);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = (COUNT - chapter * 40 > 39) ? 40 : COUNT - chapter * 40;
    for(int i =0 ;i<COUNT;i++) checked.add(false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${chapter+1}일차"),
      ),
      body: ListView.builder(itemCount: count*2,itemBuilder: (context,index){
        var realIndex = index ~/ 2;
        var Chapter = (realIndex) ~/ 50;
        if(index.isOdd) return Divider();
        return ListTile(title: checked[chapter*40+realIndex]==true ? TEXT1(word[Keys[chapter*40+realIndex]]!, FontWeight.bold, 20) : TEXT1(Keys[chapter*40+realIndex], FontWeight.bold, 20)
          ,subtitle: TEXT1("${Chapter+1},${chapter*40+realIndex+1}",FontWeight.w400,15),
          onTap: () => setState(() {
            checked[chapter*40+realIndex] ^= true;
          }),
          );
      }
      )
    );
  }
}

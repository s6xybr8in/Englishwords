import 'package:app/word.dart';
import 'package:app/wordviews.dart';
import 'package:flutter/material.dart';
import 'scrapview.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("Home",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: GridView.builder(itemCount: Chapter+1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
        ), itemBuilder: (context, index) {
          return (index==0) ? First_Index(context): Content(context,index-1);
        },),
    );
  }
}
Widget First_Index(BuildContext context){
  return SizedBox(
    height: 100,
    child: Card(
      child: ListTile(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScrapView(),)),title: Text("즐겨찾기 목록"),titleTextStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
    ),
  );
}

Widget Content(BuildContext context,int index) {
  return SizedBox(
    height: 100,
    child: Card(
      child: ListTile(onTap: () =>
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => WordViews(chapter: index),)),
        title: Text("${index+1}일차"),contentPadding: EdgeInsets.only(left: 20,top: 5),
      titleTextStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold) ),
  )
  );
}

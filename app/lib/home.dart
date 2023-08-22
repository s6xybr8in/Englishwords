import 'package:app/word.dart';
import 'package:app/wordviews.dart';
import 'package:flutter/material.dart';

import 'directview.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Direct()));
        }, icon: Icon(Icons.list))],
      ),
      body: GridView.builder(itemCount: Chapter,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ), itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: Card(
            child: ListTile(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => WordViews(chapter: index),)),title: Text("${index+1}일차"),),
          ),
        );
      },),
    );
  }
}

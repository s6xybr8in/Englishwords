
import 'package:app/word.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class ScrapView extends StatefulWidget {
  const ScrapView({super.key});

  @override
  State<ScrapView> createState() => _ScrapViewState();
}

class _ScrapViewState extends State<ScrapView> {
  List<bool> checked = List<bool>.filled(COUNT, false);
  List<String> scarp_words= [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0;i<COUNT;i++){
      if(Scrap[i]==1) scarp_words.add(Keys[i]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("즐겨찾기 목록"),
      ),
      body: ListView.builder(itemCount: scarp_words.length*2,itemBuilder: (context, index) {
        var realIndex = index ~/ 2;
        if(index.isOdd) return Divider();
        return ListTile(
          title: checked[realIndex] == true
              ? TEXT1(
              word[scarp_words[realIndex]]!, FontWeight.bold, 20)
              : TEXT1(scarp_words[realIndex], FontWeight.bold, 24),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Scrap[Keys.indexOf(scarp_words[realIndex])] ^= 1;
                    });
                  },
                  icon: (Scrap[Keys.indexOf(scarp_words[realIndex])] == 1)
                      ? Icon(
                    Icons.star,
                  )
                      : Icon(Icons.star_border),
                  iconSize: 20)
            ],
          ),
          onTap: () => setState(() {
            checked[realIndex] ^= true;
          }),
        );
      },)
    );
  }
}




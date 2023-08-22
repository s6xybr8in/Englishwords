
import 'package:app/word.dart';
import 'package:flutter/material.dart';

class ScrapView extends StatefulWidget {
  const ScrapView({super.key});

  @override
  State<ScrapView> createState() => _ScrapViewState();
}

class _ScrapViewState extends State<ScrapView> {
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
        title: Text("Scarp"),
      ),
      body: ListView.builder(itemCount: scarp_words.length*2,itemBuilder: (context, index) {
        var realIndex = index ~/ 2;
        if(index.isOdd) return Divider();
        return ListTile(title: Text("${scarp_words[realIndex]}",textAlign: TextAlign.center,textScaleFactor: 1.4),);
      },)
    );
  }
}

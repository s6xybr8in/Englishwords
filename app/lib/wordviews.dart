import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'word.dart';


class UNI with ChangeNotifier{
  int INDEX = 0;
  final int chapter;
  UNI(this.chapter);
}

class WordViews extends StatefulWidget {
  WordViews({required this.chapter, super.key});

  final int chapter;

  @override
  State<WordViews> createState() => _WordViewsState(chapter);
}

class _WordViewsState extends State<WordViews> {
  List<Widget> bodylist = [];
  var count = 0;
  int selected = 0;
  List<bool> _selection = [true, false];
  final int chapter;

  _WordViewsState(this.chapter);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = (COUNT - chapter * 40 > 39) ? 40 : COUNT - chapter * 40;
    bodylist.add(listview(count));
    bodylist.add(Consumer(builder: (context, value, child) => DirectView(count: count),));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> UNI(chapter),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text("${chapter + 1}일차"),
          actions: [
            ToggleButtons(
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < _selection.length; i++) {
                      _selection[i] = i == index;
                    }
                    selected = index;
                  });
                },
                children: [Icon(Icons.list), Icon(Icons.grid_view_rounded)],
                isSelected: _selection)
          ],
        ),
        body: bodylist[selected],
        bottomNavigationBar: (selected == 0)
            ? null
            : Consumer<UNI>(
          builder: (context, uni, child) => BottomNavigationBar(
              onTap: (value) {
                if (uni.INDEX < count&&value == 1) {
                    uni.INDEX++;
                    uni.notifyListeners();

                } else if (uni.INDEX>0 && value == 0) {
                  uni.INDEX--;
                  uni.notifyListeners();
                } else if (value == 2) {
                  Scrap[uni.INDEX] ^= 1;
                  setState(() {});
                }
              },
              items: [
                BottomNavigationBarItem(
                    label: 'UP', icon: Icon(Icons.arrow_circle_up)),
                BottomNavigationBarItem(
                    label: 'DOWN', icon: Icon(Icons.arrow_circle_down)),
                BottomNavigationBarItem(
                    label:'Scrap', icon: (Scrap[uni.INDEX]==1) ? Icon(Icons.star): Icon(Icons.star_border)),
              ]),
            ),
      ),
    );
  }
}


class DirectView extends StatefulWidget {
  final int count;

  DirectView(
      {required this.count,
        super.key});

  @override
  State<DirectView> createState() =>
      _DirectViewState(count: count);
}

class _DirectViewState extends State<DirectView> {
  final int count;

  _DirectViewState(
      {required this.count});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(),
      scrollDirection: Axis.vertical,
      itemCount: count,
      itemBuilder: (context, index) {
        if (Provider.of<UNI>(context).INDEX > index){
          index = Provider.of<UNI>(context).INDEX;
          Provider.of<UNI>(context,listen: false).notifyListeners();
        }
        else
          index = Provider.of<UNI>(context).INDEX;
        return Container(
            child: Card(
              child: Center(
                child: TextButton(
                  onPressed: () {
                      print(Provider.of<UNI>(context).INDEX);
                      Provider.of<UNI>(context,listen: false).notifyListeners();
                  },
                  child: Text("${Keys[index + (Provider.of<UNI>(context).chapter * 40)]}",
                      textScaleFactor: 3),),
              ),
            ));
      },
    );
  }
}

class listview extends StatefulWidget {
  const listview(this.count, {super.key});

  final int count;

  @override
  State<listview> createState() => _listviewState(count);
}

class _listviewState extends State<listview> {
  List<bool> checked = [];
  final int count;

  _listviewState(this.count);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < COUNT; i++)
      checked.add(false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: count * 2,
        itemBuilder: (context, index) {
          var realIndex = index ~/ 2;
          var Chapter = (realIndex) ~/ 50;
          if (index.isOdd) return Divider();
          return ListTile(
            title: checked[Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex] == true
                ? TEXT1(
                word[Keys[Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex]]!, FontWeight.bold, 20)
                : TEXT1(Keys[Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex], FontWeight.bold, 20),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TEXT1("${Chapter + 1},${Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex + 1}",
                    FontWeight.w400, 15),
                IconButton(
                    onPressed: () {
                      setState(() {
                        Scrap[Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex] ^= 1;
                      });
                    },
                    icon: (Scrap[Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex] == 1)
                        ? Icon(
                      Icons.star,
                    )
                        : Icon(Icons.star_border),
                    iconSize: 20)
              ],
            ),
            onTap: () =>
                setState(() {
                  checked[Provider.of<UNI>(context,listen: false).chapter * 40 + realIndex] ^= true;
                }),
          );
        });
  }
}

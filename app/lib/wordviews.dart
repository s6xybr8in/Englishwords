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
  _WordViewsState(this.chapter);


  List<Widget> bodylist = [];
  List<bool> _selection = [true, false];
  final int chapter;
  var count = 0;
  int selected = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = (COUNT - chapter * 40 > 39) ? 40 : COUNT - chapter * 40; //앞으로의 단어 갯수가 40이상 크면 MAX_COUNT 인 40으로 지정 아니면 남은 갯수만큼 지정
    bodylist.add(listview(count));
    bodylist.add(DirectView(count: count));
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



//==================================================================================
//==================================================================================
//==================================================================================
//==================================================================================
////===============================Direct View======================================
class DirectView extends StatefulWidget {
  final int count;

  DirectView({required this.count});

  @override
  State<DirectView> createState() => _DirectViewState(count: count);
}

class _DirectViewState extends State<DirectView> {
  final int count; //max count
  List<bool> checked = List<bool>.filled(COUNT, false); //영여인지 뜻인지 check 전체 단어 갯수만큼
  _DirectViewState({required this.count});


  // setState() or markNeedsBuild() called during build. 오류 발생
  // Bottom 의 up,down 버튼 누를때
  // DirectView의 TextButton 눌렀을 때
  // DirectView의 스크롤 고정됨
  @override
  Widget build(BuildContext context) {
    final int chapter = Provider.of<UNI>(context,listen: false).chapter;
    return PageView.builder(
      controller: PageController(),
      scrollDirection: Axis.vertical,
      itemCount: count,
      itemBuilder: (context, index) {
        if (Provider.of<UNI>(context).INDEX > index){
          index = Provider.of<UNI>(context,listen: false).INDEX;
          Provider.of<UNI>(context,listen: false).notifyListeners();
        }
        else
          index = Provider.of<UNI>(context).INDEX;
        return Container(
            child: Card(
              child: Center(
                child: TextButton(
                  onPressed: () {
                    checked[index+ chapter*40] ^= true;
                    setState(() {});
                  },
                  child: (checked[index+ chapter*40]==true) ? Text("${word[Keys[index + (chapter * 40)]]}",textScaleFactor: 2.4,) : Text("${Keys[index + (chapter * 40)]}",textScaleFactor: 3),),
              ),
            ));
      },
    );
  }
}

//==================================================================================
//==================================================================================
//==================================================================================
//==================================================================================






//==================================================================================
//==================================================================================
//==================================================================================
//==================================================================================
//=================================List View========================================

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
    final int chapter = Provider.of<UNI>(context,listen: false).chapter;
    return ListView.builder(
        itemCount: count * 2,
        itemBuilder: (context, index) {
          var realIndex = index ~/ 2;
          var Chapter = (realIndex) ~/ 50;
          if (index.isOdd) return Divider();
          return ListTile(
            title: checked[chapter * 40 + realIndex] == true
                ? TEXT1(
                word[Keys[chapter * 40 + realIndex]]!, FontWeight.bold, 20)
                : TEXT1(Keys[chapter * 40 + realIndex], FontWeight.bold, 20),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TEXT1("${Chapter + 1},${chapter * 40 + realIndex + 1}",
                    FontWeight.w400, 15),
                IconButton(
                    onPressed: () {
                      setState(() {
                        Scrap[chapter * 40 + realIndex] ^= 1;
                      });
                    },
                    icon: (Scrap[chapter * 40 + realIndex] == 1)
                        ? Icon(
                      Icons.star,
                    )
                        : Icon(Icons.star_border),
                    iconSize: 20)
              ],
            ),
            onTap: () =>
                setState(() {
                  checked[chapter * 40 + realIndex] ^= true;
                }),
          );
        });
  }
}

//==================================================================================
//==================================================================================
//==================================================================================
//==================================================================================

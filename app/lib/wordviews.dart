import 'package:flutter/material.dart';
import 'main.dart';
import 'word.dart';

final key1 = new GlobalKey<DirectViewState>();

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
    count = (COUNT - chapter * 40 > 39)
        ? 40
        : COUNT -
            chapter *
                40; //앞으로의 단어 갯수가 40이상 크면 MAX_COUNT 인 40으로 지정 아니면 남은 갯수만큼 지정
    bodylist.add(listview(chapter, count));
    bodylist.add(DirectView(
      chapter: chapter,
      count: count,
      key: key1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            : BottomAppBar(
                shape: CircularNotchedRectangle(),
                color: Colors.white,
                notchMargin: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          key1.currentState!.up();
                        },
                        icon: Icon(
                          Icons.arrow_circle_up,
                          size: 30,
                        )),
                    IconButton(
                        onPressed: () {
                          key1.currentState!.down();
                        },
                        icon: Icon(
                          Icons.arrow_circle_down,
                          size: 30,
                        )),
                  ],
                ),
              ));
  }
}

//==================================================================================
//==================================================================================
//==================================================================================
//==================================================================================
////===============================Direct View======================================
// setState() or markNeedsBuild() called during build. 오류 발생
// Bottom 의 up,down 버튼 누를때-↑
// DirectView의 TextButton 눌렀을 때-↑
// DirectView의 스크롤 고정됨
// 기존 index를 Provider하지 않고, PageView controll를 Provider로 지정하자
// PageView.builder가 아닌 PageView로 지정해서 NexttoPage와 PrevioustoPage 를 사용하자
// 전처리해서 Page들을 리스트 형태로 받아오자
// ㅁㅊ 그러면 스크랩을 어케 해결하지>?
// 결론 Provider 빼자
// 해결 완료
//그러나 floatting action buttion 오류 발생
//아마도 아직 값을 받아오기 직전인데 star인지 star_board인지 선택해야되서 그런것 같음
//음? 그럼 null값 허용해주고 null 값이면 child null 하고 값을 받으면 아이콘을 결정해줄수 있지 않을까?

class DirectView extends StatefulWidget {
  final int count;
  final int chapter;

  DirectView({required this.chapter, required this.count, super.key});

  @override
  State<DirectView> createState() => DirectViewState(chapter, count);
}

class DirectViewState extends State<DirectView> {
  int INDEX = 0;
  final int count; //max count
  final int chapter; // selected chapter
  List<bool> checked =
      List<bool>.filled(COUNT, false); //영여인지 뜻인지 check 전체 단어 갯수만큼
  DirectViewState(this.chapter, this.count);
  bool variable = false;
  int get_scrap(){
    return Scrap[INDEX];
  }

  void checking_scrap() {
    Scrap[INDEX] ^= 1;
    variable = true;
    setState(() {});
  }

  void up() {
    if (INDEX ==0) return;
    INDEX--;
    variable = true;
    setState(() {});
  }
  void down() {
    if (INDEX == count-1) return;
    INDEX++;
    variable = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(keepPage: false);
    return PageView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        if (variable) {
          index = INDEX;
          variable = false;
        } else {
          INDEX = index;
        }
        return Column(
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 10),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(top:10,right: 10),
                          child: IconButton(icon: (get_scrap()==1) ? Icon(Icons.star) : Icon(Icons.star_border),
                            onPressed: (){
                              checking_scrap();
                            },
                          )
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Center(
                              child: ListTile(
                                title: Text(
                                    "${Keys[chapter * 40 + index]}", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),Expanded(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 10,right: 10),
                  child: Center(
                    child: ListTile(
                      title: Text(
                          "${word[Keys[chapter * 40 + index]]}", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
                    ),
                  ),
                ),
              ),
            ]);
      },
      controller: _controller,
      scrollDirection: Axis.vertical,
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
  const listview(this.chapter, this.count, {super.key});

  final int chapter;
  final int count;

  @override
  State<listview> createState() => _listviewState(chapter, count);
}

class _listviewState extends State<listview> {
  List<bool> checked = List<bool>.filled(COUNT, false);
  final int count;
  final int chapter;

  _listviewState(this.chapter, this.count);

  @override
  Widget build(BuildContext context) {
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
            onTap: () => setState(() {
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

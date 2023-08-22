import 'package:flutter/material.dart';

class Direct extends StatelessWidget {
  const Direct({super.key});

  @override
  Widget build(BuildContext context) {
    List<Container> conlist = [];
    for (int i=0;i<100;i++) conlist.add(Container(child: Text("$i",textScaleFactor: 10,),));
    return Scaffold(
        appBar: AppBar(title: const Text('Bottom Sheet Sample')),
        body: PageView.builder(itemBuilder: (context, index) {
          return conlist[index];
        },),
        bottomNavigationBar: BottomAppBar(
          height: 40,
          child: const BottomSheetExample(),
        ),
    );
  }
}

class BottomSheetExample extends StatelessWidget {
  const BottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('showModalBottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.amber,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
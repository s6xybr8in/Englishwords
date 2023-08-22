import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  final int count;
  @immutable
  const Home({super.key,required this.count});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(itemCount: count,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        childAspectRatio: 1/2,
          mainAxisSpacing: 10,
        crossAxisSpacing: 10
      ),
          itemBuilder: (context,index){
            return Container(
              child: Text("$index"),
            );
          }),

    );
  }
}

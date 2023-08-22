import 'package:flutter/material.dart';
import 'home.dart';
import 'wordviews.dart';
import 'word.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await loadCSV();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Jamsil"
      ),
      home: Home(Keys.length),
    );
  }
}

Text TEXT1(String content,FontWeight weight,double size){
  return Text(
    "$content",
    style: TextStyle(fontWeight: weight,fontSize: size),
  );
}

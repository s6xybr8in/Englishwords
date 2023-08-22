

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

Map<String,String> word = {};
List<String> Keys = [];
int Chapter = 0;
int COUNT = 0;
Future<void> loadCSV() async{
  final _rawData = await rootBundle.loadString("csv/words.csv");
  List<List<dynamic>> list =
      const CsvToListConverter().convert(_rawData);
  for(int i = 0;i<list.length;i++) {
    word.addAll({list[i][0]:list[i][1]});
  }
  Keys = word.keys.toList();
  Chapter = (Keys.length ~/ 40) + 1;
  COUNT = Keys.length;
}
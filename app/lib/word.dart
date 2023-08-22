

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

Map<String,String> word = {};
List<String> Keys = [];
Future<void> loadCSV() async{
  final _rawData = await rootBundle.loadString("csv/words.csv");
  List<List<dynamic>> list =
      const CsvToListConverter().convert(_rawData);
  for(int i = 0;i<list.length;i++) {
    bool a = word.keys.toSet().contains(list[i][0]);
    word.addAll({list[i][0]:list[i][1]});
    if(a!=false) print("${list[i][0]} ${list[i][1]}");
  }
  Keys = word.keys.toList();
}
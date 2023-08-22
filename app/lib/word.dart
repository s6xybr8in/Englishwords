

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

Map<String,String> word = {};
List<String> Keys = [];
int Chapter = 0;
int COUNT = 0;
List <int> Scrap = [];

Future<void> loadCSV() async{
  final _rawData = await rootBundle.loadString("csv/words.csv");
  List<List<dynamic>> list =
      const CsvToListConverter().convert(_rawData);
  final _rawdata2 = await rootBundle.loadString("csv/index.csv");
  List<List<dynamic>> list2 =
  const CsvToListConverter().convert(_rawdata2);

  for(int i = 0;i<list.length;i++) {
    word.addAll({list[i][0]:list[i][1]});
  }
  Keys = word.keys.toList();
  Chapter = (Keys.length ~/ 40) + 1;
  COUNT = Keys.length;

  for(int i = 0;i<list2.length;i++) {
    Scrap.add(list2[i][0]);
  }
}

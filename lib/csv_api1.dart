import 'package:flutter/material.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/api.dart';
import 'package:flutter_app/csv_utils.dart';
import 'package:flutter_app/csv_data1.dart';

class ApiCvs1 implements GarabgeClass {
  List<List<String>> garabgeList;
  Map<String, int> garabgeMap = new Map();
  Map<int, List<int>> garabgeClassMap = {
    GARABGE_ITEM_NONE: new List<int>(),
    GARABGE_ITEM_RECYCLABLE: new List<int>(),
    GARABGE_ITEM_HARMFUL: new List<int>(),
    GARABGE_ITEM_WET: new List<int>(),
    GARABGE_ITEM_DRY: new List<int>(),
  };

  ApiCvs1(BuildContext context) {
//    loadCSV(context, 'assets/data/api_csv1.csv');
    loadCSV2();
  }

//  void loadCSV(BuildContext context, String path) {
//    loadAsset(context, path).then((String output) {
//      garabgeList = new CsvConverter.Excel().parse(output);
//
//      for (var i = 0; i < garabgeList.length; i++) {
//        var itemName = garabgeList[i][0];
//        var itemId = convertItemIdToNormal(int.parse(garabgeList[i][1]));
//        garabgeMap[itemName] = i;
//        garabgeClassMap[itemId].add(itemName);
//      }
//    });
//  }

  void loadCSV2() {
    garabgeList = new CsvConverter.Excel().parse(csvData);
    garabgeList
        .sort((l1, l2) => l2[0].toLowerCase().compareTo(l1[0].toLowerCase()));

    for (var i = 0; i < garabgeList.length; i++) {
      var itemName = garabgeList[i][0];
      var itemId = convertItemIdToNormal(int.parse(garabgeList[i][1]));
      garabgeMap[itemName] = i;
      garabgeClassMap[itemId].add(i);
    }
  }

  Future<SearchResult> search(String search_words) async {
    var index = garabgeMap[search_words];
    if (index == null) {
      return new SearchResult(GARABGE_ITEM_NONE);
    }
    var itemId = convertItemIdToNormal(int.parse(garabgeList[index][1]));
    return SearchResult(itemId);
  }

  String describe() {
    return "https://github.com/alexayan/garbage-classification-data";
  }

  String getNextItemName(int itemId, int index) {
    if (index < 0 || index >= garabgeClassMap[itemId].length) {
      return '';
    }
    var indexOfList = garabgeClassMap[itemId][index];
    return garabgeList[indexOfList][0];
  }

  int getItemCount(int itemId) {
    return garabgeClassMap[itemId].length;
  }

  int convertItemIdToNormal(int itemId) {
    if (itemId >= 1 && itemId <= 2 - 1)
      return GARABGE_ITEM_RECYCLABLE;
    else if (itemId >= 2 && itemId <= 4 - 1)
      return GARABGE_ITEM_HARMFUL;
    else if (itemId >= 4 && itemId <= 8 - 1)
      return GARABGE_ITEM_WET;
    else
      return GARABGE_ITEM_DRY;
  }
}

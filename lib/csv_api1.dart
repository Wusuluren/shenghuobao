import 'package:flutter/material.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/api.dart';
import 'package:flutter_app/csv_utils.dart';

class ApiCvs1 implements GarabgeClass {
  List<List<String>> garabgeList;
  Map<String, int> garabgeMap = new Map();

  ApiCvs1(BuildContext context) {
    loadCSV(context, 'assets/data/api_csv1.csv');
  }

  void loadCSV(BuildContext context, String path) {
    loadAsset(context, path).then((String output) {
      garabgeList = new CsvConverter.Excel().parse(output);

      for (var i = 0; i < garabgeList.length; i++) {
        var itemName = garabgeList[i][0];
        garabgeMap[itemName] = i;
      }
    });
  }

  Future<SearchResult> search(String search_words) async {
    var index = garabgeMap[search_words];
    if (index == null) {
      return new SearchResult(GARABGE_ITEM_NONE);
    }
    var item = garabgeList[index];
    var itemId = int.parse(item[1]);
    itemId = convertItemIdToNormal(itemId);

    return SearchResult(itemId);
  }

  String describe() {
    return "https://github.com/alexayan/garbage-classification-data";
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

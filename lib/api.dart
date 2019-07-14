import 'package:flutter/material.dart';
import 'package:flutter_app/csv_api1.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/http_api.dart';

const API_CSV1 = 1;
const API_HTTP1 = 2;

abstract class GarabgeClass {
  Future<SearchResult> search(String words);

  String describe();
}

class SearchResult {
  int itemId;
  String itemName;
  String itemAssets;
  String content;

  SearchResult(int itemId) {
    this.itemId = itemId;
    this.itemName = convertFromItemIdToName(itemId);
    this.itemAssets = convertFromItemIdToAssets(itemId);
    this.content = convertFromItemIdToContent(itemId);
  }
}

GarabgeClass initGarabge(BuildContext context, int source) {
  switch (source) {
    case API_CSV1:
      return ApiCvs1(context);
    case API_HTTP1:
      return ApiHttp1();
  }
}

import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_app/api.dart';
import 'package:flutter_app/utils.dart';

class ApiHttp1 implements GarabgeClass {
  ApiHttp1() {
    //TODO check network
  }

  Future<SearchResult> search(String searchWords) async {
    try {
      var param = new Map<String, dynamic>();
      var data = new Map<String, dynamic>();
      data['search'] = searchWords;
      param['data'] = data;
      var dataStr = JsonEncoder().convert(data);

      int l = new DateTime.now().millisecondsSinceEpoch ~/ 1000;
      var tsp = '${l}';
      param['tsp'] = tsp;
      var did = "imei868930029467866";
      param["did"] = did;
      param["dip"] = "2";
      var dpi = "1920*1080";
      param["dpi"] = dpi;
      param["vid"] = "1";
      var ukey = "";
      param["ukey"] = ukey;

      var token = '';
      token += did;
      token += dataStr;
      token += tsp;
      token += "12321";
      print(token);

      var content = new Utf8Encoder().convert(token);
      var digest = md5.convert(content);
      token = hex.encode(digest.bytes);
      if (token.length >= 28) {
        token = token.substring(3, 28);
      }
      param["token"] = token;
      print(param);

      Response response = await Dio()
          .post("http://api.ukon.ink/searchcontentList", data: param);
//    Response response = await Dio().post("http://192.168.199.196:8900/laji", data: param);
      print(response);
      print(response.data);

//      var content = response.data['data']['businessdata']['content'];

      var itemId = int.parse(response.data['data']['businessdata']['type'][0]);
      return new SearchResult(itemId);
    } catch (e) {
      print(e);
    }
    return new SearchResult(GARABGE_ITEM_NONE);
  }

  String getNextItemName(int itemId, int index) {}

  int getItemCount(int itemId) {}

  String describe() {
    return "垃圾分类专家";
  }
}

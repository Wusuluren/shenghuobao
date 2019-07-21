import 'package:flutter/material.dart';

Future<String> loadAsset(BuildContext context, String path) async {
  return await DefaultAssetBundle.of(context).loadString(path);
}

void log(Object object, [String prefix = '']) {
  print({prefix: object});
}

void logs(List<Object> objects, [String prefix = '']) {
  for (var object in objects) {
    print({prefix: object});
  }
}

const GARABGE_ITEM_EMPTY = 0;
const GARABGE_ITEM_RECYCLABLE = 1;
const GARABGE_ITEM_HARMFUL = 2;
const GARABGE_ITEM_WET = 3;
const GARABGE_ITEM_DRY = 4;
const GARABGE_ITEM_NONE = 5;

var _itemContentMap = {
  GARABGE_ITEM_NONE: '''
  <head><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"> <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<style> div p{font-size: 18px}</style></head><div class="img-flex img-small space-between" style="margin: 0px; padding: 8px 0px 0px; display: flex; -webkit-box-align: center; align-items: center; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);">
<div class="text-layout" style="margin: -4px 0px 3px; padding: 0px; -webkit-box-flex: 1; flex: 1 1 0%; overflow: hidden;">
<p class="" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; line-height: 22px;">
暂时没有查询到对应的垃圾分类
</p>
  ''',
  GARABGE_ITEM_EMPTY: '',
  GARABGE_ITEM_RECYCLABLE: '''
  <head><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"> <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<style> div p{font-size: 18px}</style></head><div class="js_everytype" style="margin: 0px; padding: 0px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);">
<div class="img-flex img-small space-between" style="margin: 0px; padding: 8px 0px 0px; display: flex; -webkit-box-align: center; align-items: center;">
<div class="text-layout" style="margin: -4px 0px 3px; padding: 0px; -webkit-box-flex: 1; flex: 1 1 0%; overflow: hidden;">
<p class="" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; line-height: 22px;">
可回收物是指，适宜回收利用和资源化利用的生活废弃物，如废纸张、废塑料、废玻璃制品、废金属、废织物等
</p>
</div>
</div>
<div class="content-type1 fz-mid" style="margin: 0px; padding: 0px; line-height: 22px;">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
可回收物主要包括：
</h4>
<p class="space-txt " style="margin-top: 0px; margin-bottom: 0px; padding: 3px 0px; display: -webkit-box; -webkit-box-orient: vertical;">
报纸、纸箱、书本、广告单、塑料瓶、塑料玩具、油桶、酒瓶、玻璃杯、易拉罐、旧铁锅、旧衣服、包、旧玩偶、旧数码产品、旧家电
</p>
</div>
<div class="content-type2 fz-mid" style="margin: 0px; padding: 0px; line-height: 22px;">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
可回收物投放要求：
</h4>
<div class="space-txt" style="margin: 0px; padding: 3px 0px;">
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
轻投轻放
</p>
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
清洁干燥、避免污染，废纸尽量平整
</p>
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
立体包装请清空内容物，清洁后压扁投放
</p>
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
有尖锐边角的，应包裹后投放
</p>
</div>
</div>
</div>
<div class="more-box-new border-top" style="margin: 8px 0px 0px; padding: 8px 0px 0px; line-height: 22px; overflow: hidden; display: flex; -webkit-box-pack: justify; justify-content: space-between; border-top: 1px solid rgb(241, 241, 241); color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);"></div>
  ''',
  GARABGE_ITEM_HARMFUL: '''
  <head><meta charset="utf-8"> <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<style> div{font-size: 18px}</style></head><div class="img-flex img-small space-between" style="margin: 0px; padding: 8px 0px 0px; display: flex; -webkit-box-align: center; align-items: center; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);">
<div class="text-layout" style="margin: -4px 0px 3px; padding: 0px; -webkit-box-flex: 1; flex: 1 1 0%; overflow: hidden;">
<p class="clamp3" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; overflow: hidden; -webkit-line-clamp: 3; line-height: 22px;">
有害垃圾是指，对人体健康或者自然环境造成直接或潜在危害的废弃物
</p>
</div>
</div>
<div class="content-type1 fz-mid" style="margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
有害垃圾主要包括：
</h4>
<p class="space-txt clamp3" style="margin-top: 0px; margin-bottom: 0px; padding: 3px 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; overflow: hidden; -webkit-line-clamp: 3;">
废电池（充电电池、铅酸电池、镍镉电池、纽扣电池等）、废油漆、消毒剂、荧光灯管、含汞温度计、废药品及其包装物等
</p>
</div>
<div class="content-type2 fz-mid" style="margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
有害垃圾投放要求：
</h4>
<div class="space-txt" style="margin: 0px; padding: 3px 0px;">
<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px 0px 0px 9px; position: relative;">
投放时请注意轻放
</p>
<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px 0px 0px 9px; position: relative;">
易破损的请连带包装或包裹后轻放
</p>
<p style="margin-top: 0px; margin-bottom: 0px; padding: 0px 0px 0px 9px; position: relative;">
如易挥发，请密封后投放
</p>
</div>
</div>
  ''',
  GARABGE_ITEM_WET: '''
  <head><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"> <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<style> div p{font-size: 18px}</style></head><div class="img-flex img-small space-between" style="margin: 0px; padding: 8px 0px 0px; display: flex; -webkit-box-align: center; align-items: center; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);">
<div class="text-layout" style="margin: -4px 0px 3px; padding: 0px; -webkit-box-flex: 1; flex: 1 1 0%; overflow: hidden;">
<p class="" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; line-height: 22px;">
湿垃圾是指，日常生活垃圾产生的容易腐烂的生物质废弃物
</p>
</div>
</div>
<div class="content-type1 fz-mid" style="margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
湿垃圾主要包括：
</h4>
<p class="space-txt" style="margin-top: 0px; margin-bottom: 0px; padding: 3px 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical;">
食材废料、剩饭剩菜、过期食品、蔬菜水果、瓜皮果核、花卉绿植、中药残渣等
</p>
</div>
<div class="content-type2 fz-mid" style="margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
湿垃圾投放要求：
</h4>
<div class="space-txt" style="margin: 0px; padding: 3px 0px;">
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
纯流质的食物垃圾，如牛奶等，应直接倒进下水口
</p>
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
有包装物的湿垃圾应将包装物去除后分类投放，包装物请投放到对应的可回收物或干垃圾容器
</p>
</div>
</div>
  ''',
  GARABGE_ITEM_DRY: '''
  <head><meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge"> <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no">
<style> div p{font-size: 18px}</style></head><div class="img-flex img-small space-between" style="margin: 0px; padding: 8px 0px 0px; display: flex; -webkit-box-align: center; align-items: center; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);">
<div class="text-layout" style="margin: -4px 0px 3px; padding: 0px; -webkit-box-flex: 1; flex: 1 1 0%; overflow: hidden;">
<p class="" style="margin-top: 0px; margin-bottom: 0px; padding: 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; line-height: 22px;">
干垃圾是指，除可回收物、有害垃圾、湿垃圾以外的其它生活废弃物
</p>
</div>
</div>
<div class="content-type1 fz-mid" style="margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
干垃圾主要包括：
</h4>
<p class="space-txt" style="margin-top: 0px; margin-bottom: 0px; padding: 3px 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; ">
餐盒、餐巾纸、湿纸巾、卫生间用纸、塑料袋、食品包装袋、污染严重的纸、烟蒂、纸尿裤、一次性杯子、大骨头、贝壳、花盆等
</p>
</div>
<div class="content-type2 fz-mid" style="margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);">
<h4 style="margin: 0px; padding: 8px 0px 0px;">
干垃圾投放要求：
</h4>
<div class="space-txt" style="margin: 0px; padding: 3px 0px;">
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
尽量沥干水分
</p>
<p style="margin-top: 0px; margin-bottom: 0px; position: relative;">
难以辨识类别的生活垃圾投入干垃圾容器内
</p>
</div>
</div>
  ''',
};

String convertFromItemIdToContent(int itemId) {
  return _itemContentMap[itemId];
}

//var _assetsItemImageMap = {
//  GARABGE_ITEM_NONE: '',
//  GARABGE_ITEM_EMPTY: '',
//  GARABGE_ITEM_RECYCLABLE: 'assets/images/type_recyclable.png',
//  GARABGE_ITEM_HARMFUL: 'assets/images/type_harmful.png',
//  GARABGE_ITEM_WET: 'assets/images/type_wet.png',
//  GARABGE_ITEM_DRY: 'assets/images/type_dry.png',
//};
//
//String convertFromItemIdToAssets(int itemId) {
//  return _assetsItemImageMap[itemId];
//}

var _itemNameMap = {
  GARABGE_ITEM_NONE: '未查询到对应的垃圾分类',
  GARABGE_ITEM_EMPTY: '',
  GARABGE_ITEM_RECYCLABLE: '可回收垃圾',
  GARABGE_ITEM_HARMFUL: '有害垃圾',
  GARABGE_ITEM_WET: '湿垃圾',
  GARABGE_ITEM_DRY: '干垃圾',
};

String convertFromItemIdToName(int itemId) {
  return _itemNameMap[itemId];
}

var _itemEnNameMap = {
  GARABGE_ITEM_NONE: '',
  GARABGE_ITEM_EMPTY: '',
  GARABGE_ITEM_RECYCLABLE: 'RECYCLABLEWASTE',
  GARABGE_ITEM_HARMFUL: 'HAZARDOUSWASTE',
  GARABGE_ITEM_WET: 'HOUSEHOLDFOODWASTE',
  GARABGE_ITEM_DRY: 'RESIDUALWASTE',
};

String convertFromItemIdToEnName(int itemId) {
  return _itemEnNameMap[itemId];
}

var _itemColorMap = {
  GARABGE_ITEM_NONE: Colors.white,
  GARABGE_ITEM_EMPTY: Colors.white,
  GARABGE_ITEM_RECYCLABLE: Colors.blue,
  GARABGE_ITEM_HARMFUL: Colors.red,
  GARABGE_ITEM_WET: Colors.brown,
  GARABGE_ITEM_DRY: Colors.black45,
};

Color convertFromItemIdToColor(int itemId) {
  return _itemColorMap[itemId];
}

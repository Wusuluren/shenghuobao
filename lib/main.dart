import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_app/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '垃圾分类指南',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '垃圾分类指南'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

int _counter = 0;

void _navigateSearchResultPage(BuildContext context) {
  var list = new List<String>();
  list.add('瓜子');
  list.add('卫生纸');
  list.add('虾壳');
  list.add('电池');
  list.add('剩饭');
  _counter++;
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SearchResultPage(searchWords: list[_counter % 5]);
  }));
}

class _MyHomePageState extends State<MyHomePage> {
  static int _counter = 0;

  void _incrementCounter() {
    var list = new List<String>();
    list.add('瓜子');
    list.add('卫生纸');
    list.add('虾壳');
    list.add('电池');
    list.add('剩饭');
    _counter++;
    getResult(list[_counter % 5]);
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//            Text('一键查询免烦恼，从我做起爱环保',),
            SearchBar(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  HotSearch(),
                  BasicClass(),
//                  Text('生产生活垃圾的个人是生活垃圾分类投放的责任主体，应当将生活垃圾分别投放至相应的收集容器哦'),
                  Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '分享给朋友',
        child: Icon(Icons.screen_share),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
//      padding: const EdgeInsets.all(32.0),
      //整体是一个水平布局
      child: new Row(
        children: [
          //这里用Expanded的好处就是 会占用icon之外的剩余空间
          new Expanded(
              //在Expanded内创建一个垂直布局 放置两个文本
              child: new Column(
            //文本是起始端对齐
//                  crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Container(
//                      padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
//                              contentPadding: EdgeInsets.all(10.0),
                    icon: Icon(Icons.search),
                    labelText: '请输入正确名称（包括材质）',
                  ),
                ),
              ),
            ],
          )),
          FlatButton(
            child: Text('搜索'),
            color: Colors.blue,
            textColor: Colors.blue,
            onPressed: () {
              _navigateSearchResultPage(context);
            },
          ),
        ],
      ),
    );
  }
}

class HotSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
//      padding: const EdgeInsets.all(32.0),
      child: new Column(
//        mainAxisAlignment: MainAxisAlignment.start,
        children: [
//          Text('热门搜索'),
          Row(
            children: <Widget>[
              Chip(
                label: Text('虾壳'),
              ),
              Chip(
                label: Text('面膜'),
              ),
              Chip(
                label: Text('瓜子壳'),
              ),
              Chip(
                label: Text('塑料袋'),
              ),
              Chip(
                label: Text('医用棉签'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BasicClass extends StatelessWidget {
  double scaleValue = 1;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('生活垃圾基本分类'),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        "images/home_icon_recyclable.png",
                        scale: scaleValue,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "images/hone_icon_harmful.png",
                        scale: scaleValue,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        "images/home_icon_wet.png",
                        scale: scaleValue,
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        "images/home_icon_dry.png",
                        scale: scaleValue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text('备注：湿垃圾（又名厨余垃圾、易腐垃圾、餐厨垃圾），干垃圾（又名其它垃圾），生活垃圾分类同时包括：装修垃圾和大件垃圾'),
          Text('参与垃圾分类，保护地球家园，共创美好世界。'),
        ],
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final searchWords;
  static String _resultContent = '';

  SearchResultPage({Key key, @required this.searchWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('返回'),
      ),
      body: SingleChildScrollView(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FutureBuilder<Map<String, dynamic>>(
                      future: getResult(searchWords),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasData) {
                          var result = snapshot.data;
                          if (result == null || result['code'] != 0) {
                            _resultContent = '';
                          } else {
                            _resultContent =
                                result['data']['businessdata']['content'];
                          }
                          return Html(data: _resultContent);
                        } else if (snapshot.hasError) {
//                        return new Text("${snapshot.error}");
                        }
                        // By default, show a loading spinner
                        return new CircularProgressIndicator();
                      }),
                  Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class SearchResultPage extends StatefulWidget {
  final searchWords;

  SearchResultPage({Key key, @required this.searchWords}) : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState(searchWords: searchWords);
}

class _SearchResultPageState extends State<SearchResultPage> {
  final String searchWords;
  static String _resultContent = '';

  _SearchResultPageState({Key key, @required this.searchWords})  {
//    print("@@@"+searchWords);
//    getResult(searchWords).then((result) {
//      _result=result;
//      print('##then##');
//      print(_result);
////      _onGetResult(result);
//    }).whenComplete((){
//      print('##whenComplete##');
//      print(_result);
//      _onGetResult(_result);
////      if(_result==null) {
////        return;
////      }
////      print('@@@'+_result.toString());
////      if(_result['code']==0) {
////        _onGetResult(_result);
//////          _resultContent = result['data']['businessdata']['content'];
////      }
//
//    });
  }

//  @override
//  void initState(){
//    super.initState();
//    getResult(searchWords).then((result){
//      print('!!!'+result.toString());
//      _onGetResult(result);
//    });
//  }

//  void _onGetResult(Map<String, dynamic> result) {
//    setState(() {
//      if(result==null || result['code']!=0){
////        _resultContent='<head><meta charset=\"utf-8\"> <meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0,user-scalable=no\">\n    <style> div{font-size: 18px}<\/style><\/head><div class=\"img-flex img-small space-between\" style=\"margin: 0px; padding: 8px 0px 0px; display: flex; -webkit-box-align: center; align-items: center; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; font-size: 14px; white-space: normal; background-color: rgb(255, 255, 255);\">\n    <div class=\"text-layout\" style=\"margin: -4px 0px 3px; padding: 0px; -webkit-box-flex: 1; flex: 1 1 0%; overflow: hidden;\">\n        <p class=\"clamp3\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; overflow: hidden; -webkit-line-clamp: 3; line-height: 22px;\">\n            有害垃圾是指，对人体健康或者自然环境造成直接或潜在危害的废弃物\n        <\/p>\n    <\/div>\n<\/div>\n<div class=\"content-type1 fz-mid\" style=\"margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">\n    <h4 style=\"margin: 0px; padding: 8px 0px 0px;\">\n        有害垃圾主要包括：\n    <\/h4>\n    <p class=\"space-txt clamp3\" style=\"margin-top: 0px; margin-bottom: 0px; padding: 3px 0px; display: -webkit-box; text-overflow: ellipsis; -webkit-box-orient: vertical; overflow: hidden; -webkit-line-clamp: 3;\">\n        废电池（充电电池、铅酸电池、镍镉电池、纽扣电池等）、废油漆、消毒剂、荧光灯管、含汞温度计、废药品及其包装物等\n    <\/p>\n<\/div>\n<div class=\"content-type2 fz-mid\" style=\"margin: 0px; padding: 0px; font-size: 14px; line-height: 22px; color: rgb(34, 34, 34); font-family: Arial, Helvetica, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\">\n    <h4 style=\"margin: 0px; padding: 8px 0px 0px;\">\n        有害垃圾投放要求：\n    <\/h4>\n    <div class=\"space-txt\" style=\"margin: 0px; padding: 3px 0px;\">\n        <p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 0px 0px 9px; position: relative;\">\n            投放时请注意轻放\n        <\/p>\n        <p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 0px 0px 9px; position: relative;\">\n            易破损的请连带包装或包裹后轻放\n        <\/p>\n        <p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px 0px 0px 9px; position: relative;\">\n            如易挥发，请密封后投放\n        <\/p>\n    <\/div>\n<\/div>\n<p>\n    <br\/>\n<\/p>';
//      } else {
//        _resultContent = result['data']['businessdata']['content'];
//      }
//      print('###'+result.toString());
//      print('@@@'+_resultContent);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('返回'),
      ),
      body: SingleChildScrollView(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FutureBuilder<Map<String,dynamic>>(
                      future: getResult(searchWords),
                      builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var result=snapshot.data;
                        if(result==null || result['code']!=0){
                          _resultContent='';
                        } else {
                          _resultContent = result['data']['businessdata']['content'];
                        }
                        return Html(data: _resultContent);
                      } else if (snapshot.hasError) {
//                        return new Text("${snapshot.error}");
                      }

                      // By default, show a loading spinner
                      return new CircularProgressIndicator();
                  }),
//                  Html(data: _resultContent),
                  Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

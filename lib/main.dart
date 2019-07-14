import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_app/api.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/widget.dart';

GarabgeClass garabgeClass;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    garabgeClass = initGarabge(context, API_CSV1);

    return MaterialApp(
      title: '垃圾分类指南',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '垃圾分类指南'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void _navigateSearchResultPage(BuildContext context, String search_words) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return SearchResultPage(searchWords: search_words);
  }));
}

void _navigateClassItemPage(BuildContext context, int itemId) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return BasicClassPage(itemId: itemId);
  }));
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
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

//                new Container(
//                  decoration: new BoxDecoration(
//                    border: new Border(top: new BorderSide(color: Theme.of(context).disabledColor, style:BorderStyle.none))
//                  ),
//                  child: new Padding(
//                    padding: const EdgeInsets.only(bottom: 5),
//                    child: new Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准',
//                      textAlign: TextAlign.center,
////                      style: new TextStyle(
////                        fontSize: 1.0,
////                      ),
//                    ),
//                  ),
//                )
                ],
              ),
            ),
          ],
        ),
      ),

//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: '分享给朋友',
//        child: Icon(Icons.screen_share),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SearchBar extends StatelessWidget {
  var _search_words = '';

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
                      onChanged: (String input) => {_search_words = input},
                    ),
                  ),
                ],
              )),
          FlatButton(
            child: Text('搜索'),
            textColor: Colors.blue,
            onPressed: () {
              if (_search_words.length == 0) {
                showAlertPage(context, '还没有输入垃圾哦');
                return;
              }
              _navigateSearchResultPage(context, _search_words);
            },
          ),
        ],
      ),
    );
  }
}

class HotSearch extends StatelessWidget {
  var _hotWords = ['虾壳', '面膜', '瓜子壳', '塑料袋', '医用棉签'];

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
              ActionChip(
                label: Text(_hotWords[0]),
                onPressed: () =>
                {
                  _navigateSearchResultPage(context, _hotWords[0])
                },
              ),
              ActionChip(
                label: Text(_hotWords[1]),
                onPressed: () =>
                {
                  _navigateSearchResultPage(context, _hotWords[1])
                },
              ),
              ActionChip(
                label: Text(_hotWords[2]),
                onPressed: () =>
                {
                  _navigateSearchResultPage(context, _hotWords[2])
                },
              ),
              ActionChip(
                label: Text(_hotWords[3]),
                onPressed: () =>
                {
                  _navigateSearchResultPage(context, _hotWords[3])
                },
              ),
              ActionChip(
                label: Text(_hotWords[4]),
                onPressed: () =>
                {
                  _navigateSearchResultPage(context, _hotWords[4])
                },
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
//          Text('生活垃圾基本分类'),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialTapWidget(
                          child: Image.asset(
                            "assets/images/home_icon_recyclable.png",
                            scale: scaleValue,
                          ),
                          onTap: () =>
                          {
                            _navigateClassItemPage(
                                context, GARABGE_ITEM_RECYCLABLE)
                          }
                      ),
                    ),
                    Expanded(
                      child: MaterialTapWidget(
                          child: Image.asset(
                            "assets/images/hone_icon_harmful.png",
                            scale: scaleValue,
                          ),
                          onTap: () =>
                          {
                            _navigateClassItemPage(
                                context, GARABGE_ITEM_HARMFUL)
                          }
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialTapWidget(
                          child: Image.asset(
                            "assets/images/home_icon_wet.png",
                            scale: scaleValue,
                          ),
                          onTap: () =>
                          {
                            _navigateClassItemPage(context, GARABGE_ITEM_WET)
                          }
                      ),
                    ),
                    Expanded(
                      child: MaterialTapWidget(
                          child: Image.asset(
                            "assets/images/home_icon_dry.png",
                            scale: scaleValue,
                          ),
                          onTap: () =>
                          {
                            _navigateClassItemPage(context, GARABGE_ITEM_DRY)
                          }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
//          Text('备注：湿垃圾（又名厨余垃圾、易腐垃圾、餐厨垃圾），干垃圾（又名其它垃圾），生活垃圾分类同时包括：装修垃圾和大件垃圾'),
//          Text('参与垃圾分类，保护地球家园，共创美好世界。'),
        ],
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final searchWords;
  final _itemNameFontSize = 1.0;

  SearchResultPage({Key key, @required this.searchWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(searchWords),
      ),
      body: SingleChildScrollView(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FutureBuilder<SearchResult>(
                      future: garabgeClass.search(searchWords),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasData) {
                          var result = snapshot.data;
                          if (result.itemId == GARABGE_ITEM_NONE) {
                            return new Column(
                              children: <Widget>[
//                                Text(result.itemName,
//                                  textAlign: TextAlign.center,
//                                  style: new TextStyle(
//                                    fontSize: _itemNameFontSize,
//                                  ),
//                                ),
                                Html(data: result.content),
                              ],
                            );
                          } else {
                            return new Column(
                              children: <Widget>[
//                                Text(result.itemName,
//                                  textAlign: TextAlign.center,
//                                  style: new TextStyle(
//                                    fontSize: _itemNameFontSize,
//                                  ),
//                                ),
                                Image.asset(
                                  result.itemAssets,
//                                scale: scaleValue,
                                ),
                                Html(data: result.content),
                              ],
                            );
                          }
                        } else if (snapshot.hasError) {
                          var result = new SearchResult(GARABGE_ITEM_NONE);
                          return new Column(
                            children: <Widget>[
//                              Text(result.itemName,
//                                textAlign: TextAlign.center,
//                                style: new TextStyle(
//                                  fontSize: _itemNameFontSize,
//                                ),
//                              ),
                              Html(data: result.content),
                            ],
                          );
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

class BasicClassPage extends StatelessWidget {
  final itemId;
  final _itemNameFontSize = 1.0;

  BasicClassPage({Key key, @required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var result = new SearchResult(itemId);
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(result.itemName),
      ),
      body: SingleChildScrollView(
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
//                  Text(result.itemName,
//                    textAlign: TextAlign.center,
//                    style: new TextStyle(
//                      fontSize: _itemNameFontSize,
//                    ),
//                  ),
                  Image.asset(
                    result.itemAssets,
//                    scale: scaleValue,
                  ),
                  Html(data: result.content),
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

void showAlertPage(BuildContext context, String message,
    {String title = '温馨提示', String confirm = '好的'}) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new AlertDialog(
//        title: new Text(title),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(confirm, style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  ).then((val) {
    print(val);
  });
}

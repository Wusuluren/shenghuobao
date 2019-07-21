import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_app/api.dart';
import 'package:flutter_app/utils.dart';
import 'package:flutter_app/widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

GarabgeClass _garabgeClass;

var _searchResult = SearchResult(GARABGE_ITEM_EMPTY);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _garabgeClass = initGarabge(context, API_CSV1);

    return MaterialApp(
      title: '生活宝',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: '生活宝'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('zh', 'CH'), // Chinese
      ],
      locale: Locale('zh'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//void _navigateSearchResultPage(BuildContext context, String search_words) {
//  Navigator.push(context, MaterialPageRoute(builder: (context) {
//    return SearchResultPage(searchWords: search_words);
//  }));
//}

void _navigateClassItemPage(BuildContext context, int itemId) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return BasicClassWidgetPage(itemId: itemId);
  }));
}

class _MyHomePageState extends State<MyHomePage> {
  var _search_words = '';
  final TextEditingController _controller = new TextEditingController();

  void _getSearchResult(String search_words) async {
    var _result = await _garabgeClass.search(search_words);
    setState(() {
      _searchResult = _result;
    });
  }

  FlatButton makeOneItemButton(BuildContext context, int itemId) {
    var result = SearchResult(itemId);
    return FlatButton(
      child: Column(
        children: <Widget>[
          Text(result.itemName),
          Text(
            result.itemEnName,
            softWrap: false,
            overflow: TextOverflow.clip,
            maxLines: 1,
            textScaleFactor: 0.5,
          ),
        ],
      ),
      color: result.color,
      textColor: Colors.white,
      padding: EdgeInsets.all(32),
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      onPressed: () => {_navigateClassItemPage(context, itemId)},
    );
  }

  Container makeSearchResultLabel() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Column(
                children: <Widget>[
                  Text(
                    _searchResult.itemName,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _searchResult.itemEnName,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    textScaleFactor: 0.5,
                  ),
                ],
              ),
              color: _searchResult.color,
              textColor: Colors.white,
              padding: EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }

  Container _searchBarWidget() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                icon: Icon(Icons.search),
                hintText: '请输入正确名称（包括材质）',
              ),
              onChanged: (String input) => {_search_words = input},
            ),
          ),
          FlatButton(
            child: Text('搜索'),
            textColor: Colors.blue,
            onPressed: () {
              if (_search_words.length == 0) {
                showAlertPage(context, '还没有输入垃圾哦');
                return;
              }
//              _navigateSearchResultPage(context, _search_words);
              _getSearchResult(_search_words);
            },
          ),
        ],
      ),
    );
  }

  Container _hotSearchWidget() {
    var getAllActionChip = () {
      var _hotWords = ['虾壳', '面膜', '瓜子壳', '塑料袋', '医用棉签'];
      var list = List<ActionChip>();
      for (int i = 0; i < _hotWords.length; i++) {
        list.add(ActionChip(
          label: Text(_hotWords[i]),
//        onPressed: () => {_navigateSearchResultPage(context, _hotWords[i])},
          onPressed: () => {
                _search_words = _hotWords[i],
                _controller.text = _hotWords[i],
                _getSearchResult(_hotWords[i])
              },
        ));
      }
      return list;
    };

    return Container(
      child: Column(
        children: [
          Row(
            children: getAllActionChip(),
          )
        ],
      ),
    );
  }

  Container _searchResultWidget() {
    if (_searchResult.itemId == GARABGE_ITEM_EMPTY) {
      return Container();
    }
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            makeSearchResultLabel(),
            Html(data: _searchResult.content),
//            Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准'),
          ],
        ),
      ),
    );
  }

  Container _basicClassWidget() {
    return new Container(
      padding: new EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child:
                          makeOneItemButton(context, GARABGE_ITEM_RECYCLABLE),
                    ),
                    Expanded(
                      child: makeOneItemButton(context, GARABGE_ITEM_HARMFUL),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: makeOneItemButton(context, GARABGE_ITEM_DRY),
                    ),
                    Expanded(
                      child: makeOneItemButton(context, GARABGE_ITEM_WET),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
//        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: new EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _searchBarWidget(),
                  _hotSearchWidget(),
                  _searchResultWidget(),
                  _basicClassWidget(),
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

//class BasicClassWidget extends StatelessWidget {
//  double scaleValue = 1;
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      padding: new EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
//      child: new Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        children: [
//          Container(
//            child: Column(
//              children: <Widget>[
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: MaterialTapWidget(
//                          child: Image.asset(
//                            "assets/images/home_icon_recyclable.png",
//                            scale: scaleValue,
//                          ),
//                          onTap: () => {
//                                _navigateClassItemPage(
//                                    context, GARABGE_ITEM_RECYCLABLE)
//                              }),
//                    ),
//                    Expanded(
//                      child: MaterialTapWidget(
//                          child: Image.asset(
//                            "assets/images/hone_icon_harmful.png",
//                            scale: scaleValue,
//                          ),
//                          onTap: () => {
//                                _navigateClassItemPage(
//                                    context, GARABGE_ITEM_HARMFUL)
//                              }),
//                    ),
//                  ],
//                ),
//                Row(
//                  children: <Widget>[
//                    Expanded(
//                      child: MaterialTapWidget(
//                          child: Image.asset(
//                            "assets/images/home_icon_wet.png",
//                            scale: scaleValue,
//                          ),
//                          onTap: () => {
//                                _navigateClassItemPage(
//                                    context, GARABGE_ITEM_WET)
//                              }),
//                    ),
//                    Expanded(
//                      child: MaterialTapWidget(
//                          child: Image.asset(
//                            "assets/images/home_icon_dry.png",
//                            scale: scaleValue,
//                          ),
//                          onTap: () => {
//                                _navigateClassItemPage(
//                                    context, GARABGE_ITEM_DRY)
//                              }),
//                    ),
//                  ],
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}

//class SearchResultPage extends StatelessWidget {
//  final searchWords;
//
//  SearchResultPage({Key key, @required this.searchWords}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(searchWords),
//      ),
//      body: SingleChildScrollView(
//        padding: new EdgeInsets.only(left: 8, right: 8),
//        child: Column(
//          children: <Widget>[
//            SingleChildScrollView(
//              child: Column(
//                children: <Widget>[
//                  FutureBuilder<SearchResult>(
//                      future: _garabgeClass.search(searchWords),
//                      builder: (context, snapshot) {
//                        print(snapshot);
//                        if (snapshot.hasData) {
//                          var result = snapshot.data;
//                          if (result.itemId == GARABGE_ITEM_NONE) {
//                            return new Column(
//                              children: <Widget>[
//                                Html(data: result.content),
//                              ],
//                            );
//                          } else {
//                            return new Column(
//                              children: <Widget>[
//                                Image.asset(
//                                  result.itemAssets,
////                                scale: scaleValue,
//                                ),
//                                Html(data: result.content),
//                              ],
//                            );
//                          }
//                        } else if (snapshot.hasError) {
//                          var result = new SearchResult(GARABGE_ITEM_NONE);
//                          return new Column(
//                            children: <Widget>[
//                              Html(data: result.content),
//                            ],
//                          );
//                        }
//                        // By default, show a loading spinner
//                        return new CircularProgressIndicator();
//                      }),
//                  Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准'),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

class BasicClassWidgetPage extends StatelessWidget {
  final itemId;

  BasicClassWidgetPage({Key key, @required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    var result = new SearchResult(itemId);
    return Scaffold(
      appBar: AppBar(
        title: Text(convertFromItemIdToName(itemId)),
      ),
      body: new ListView.builder(
        padding: new EdgeInsets.all(5.0),
        itemExtent: 20.0,
        itemCount: _garabgeClass.getItemCount(itemId),
        itemBuilder: (BuildContext context, int index) {
          if (index.isOdd) return new Divider();
          return new Text(_garabgeClass.getNextItemName(itemId, index));
        },
      ),
//      body: SingleChildScrollView(
//        padding: new EdgeInsets.only(left: 8, right: 8),
//        child: Column(
//          children: <Widget>[
//            SingleChildScrollView(
//              child: Column(
//                children: <Widget>[
//                  Image.asset(
//                    result.itemAssets,
////                    scale: scaleValue,
//                  ),
//                  Html(data: result.content),
//                  Text('本查询系统仅供参考，具体分类要求以归属地专业管理部门为准'),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
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

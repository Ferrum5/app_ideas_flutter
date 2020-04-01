import 'package:flutter/material.dart';
import 'pages.dart';
//main方法
void main() => runApp(MyApp());
//主Widget
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //这里将首页'/'加入
    final routes = <String, WidgetBuilder>{'/': (context) => HomeScreen()};
    for(var category in PageCategory.categories){
      routes.addEntries(category.pages.map((page)=>MapEntry('${category.name}/${page.fileName}',page.builder)));
    }
    return MaterialApp(
      routes: routes,
      initialRoute: '/',
      title: 'App ideas flutter',
      //有initialRoute不写home
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //Tab控制器，不使用DefaultTabController自己控制
  TabController _tabController;
  //当前页下标，用于控制标题栏和底部选中状态
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    //tabbar+viewpager控制器
    _tabController =
        TabController(initialIndex: _currentTabIndex, length: 3, vsync: this)
          ..addListener(() {
            //if (!_tabController.indexIsChanging) {
              setState(() {
                _currentTabIndex = _tabController.index;
              });
            //}
          });
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  //底部3按钮
  Widget _buildBottomTabs(BuildContext context) {
    final tabs = [
      Icons.directions_walk,
      Icons.directions_bike,
      Icons.directions_car,
    ];
    return Row(
      children: [0, 1, 2].map((i) {
        return Expanded(
          child: GestureDetector(
            child: Container(
                decoration: BoxDecoration(),
                child: Center(
                  child: Icon(tabs[i],
                      //底部选中颜色
                      color: (_currentTabIndex == i)
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                )),
            onTap: () {
              //点击切换底部选中状态
              setState(() {
                _currentTabIndex = i;
              });
              //切换页面
              _tabController.animateTo(i);
            },
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(PageCategory.categories[_currentTabIndex].name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: PageCategory.categories.map((category){
                return (category.pages.length==0)?FlutterLogo():ListView.builder(
                    itemCount: category.pages.length,
                    itemBuilder: (context, index) {
                      final title = category.pages[index].name;
                      return ListTile(
                        key: ValueKey(title),
                        title: Text(title),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed('${category.name}/${category.pages[index].fileName}');
                        },
                      );
                    });
              }).toList(),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: _buildBottomTabs(context),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{'/': (context) => HomeScreen()};
    for(var category in PageCategory.categories){
      routes.addEntries(category.pages.map((page)=>MapEntry('${category.name}/${page.fileName}',page.builder)));
    }
    return MaterialApp(
      //add all pages to route
      routes: routes,
      initialRoute: '/',
      title: 'App ideas flutter',
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
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
                      color: (_currentTabIndex == i)
                          ? Theme.of(context).primaryColor
                          : Colors.black),
                )),
            onTap: () {
              setState(() {
                _currentTabIndex = i;
              });
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
                              .pushNamed('beginner/${category.pages[index].fileName}');
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

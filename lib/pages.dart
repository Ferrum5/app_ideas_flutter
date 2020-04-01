import 'package:app_ideas_flutter/beginner/bin2dec.dart';
import 'package:app_ideas_flutter/beginner/border_radius_previewer.dart';
import 'package:app_ideas_flutter/beginner/calculator.dart';
import 'package:flutter/widgets.dart';

//初中高级大分类
class PageCategory{
  //分类名
  final String name;
  //对应页面
  final List<PageEntry> pages;
  //构造
  PageCategory({@required this.name, @required this.pages});
  //所有页面列表
  static final categories = <PageCategory>[
    PageCategory(
        name: 'beginner',
        pages: [
          PageEntry(
              name: 'Bin2Dec',
              fileName: 'bin2dec',
              builder: (context)=>Bin2Dec()
          ),
          PageEntry(
              name: 'Border Radius Previewer',
              fileName: 'border_radius_previewer',
              builder: (context)=>BorderRadiusPreviewer()
          ),
          PageEntry(
            name: 'Calculator',
            fileName: 'calculator',
            builder: (context)=>Calculator(),
          ),
        ]),
    PageCategory(
      name: 'intermediate',
      pages: [],
    ),
    PageCategory(
      name: 'advanced',
      pages: [],
    ),
  ];
}

//每个页面信息
class PageEntry{
  //在列表展示用的名字
  final String name;
  //.dart文件名
  final String fileName;
  //页面builder
  final WidgetBuilder builder;
  PageEntry({@required this.name, @required this.fileName,@required this.builder});
}
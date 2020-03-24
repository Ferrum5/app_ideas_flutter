import 'package:app_ideas_flutter/beginner/bin2dec.dart';
import 'package:flutter/widgets.dart';


class PageCategory{
  final String name;
  final List<PageEntry> pages;
  PageCategory({@required this.name, @required this.pages});

  static final categories = <PageCategory>[
    PageCategory(
        name: 'beginner',
        pages: [
          PageEntry(
              name: 'bin2dec',
              builder: (context)=>Bin2Dec()
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

class PageEntry{
  final String name;
  final WidgetBuilder builder;
  PageEntry({@required this.name, @required this.builder});

}
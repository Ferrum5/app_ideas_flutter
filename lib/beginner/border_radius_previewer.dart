import 'package:flutter/material.dart';

class BorderRadiusPreviewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Border Radius Previewer'),
      ),
      body: BorderRadiusPreviewerPage(),
    );
  }
}

class BorderRadiusPreviewerPage extends StatefulWidget {
  @override
  _BorderRadiusPreviewerPageState createState() =>
      _BorderRadiusPreviewerPageState();
}

class _BorderRadiusPreviewerPageState extends State<BorderRadiusPreviewerPage> {

  BorderStyle _borderStyle = BorderStyle();

  @override
  Widget build(BuildContext context) {
    final edits = List<int>.generate(8, (i)=>i)
        .map((i) =>
        SizedBox(
          width: 60,
          height: 40,
          child: TextField(
            onChanged: (text){
              setState(() {
                _borderStyle[i] = double.tryParse(text)??0;
              });
            } ,
            decoration: InputDecoration(border: OutlineInputBorder()),
            keyboardType: TextInputType.numberWithOptions(
              signed: false,
            ),
          ),
        ))
        .toList();

    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[edits[1], edits[2]],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[edits[0], edits[7]],
                  ),
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: Container(
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: _borderStyle.borderRadius,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[edits[3], edits[4]],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[edits[6], edits[5]],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: SelectableText(_borderStyle.cssString),
        )
      ],
    );
  }
}

class BorderStyle {

  Radius border_top_left_radius = Radius.zero;
  Radius border_top_right_radius = Radius.zero;
  Radius border_bottom_right_radius = Radius.zero;
  Radius border_bottom_left_radius = Radius.zero;

  void operator []=(int index, double value) {
    switch (index) {
      case 0:
        border_top_left_radius =
            Radius.elliptical(value, border_top_left_radius.y);
        break;
      case 1:
        border_top_left_radius =
            Radius.elliptical(border_top_left_radius.x, value);
        break;
      case 2:
        border_top_right_radius =
            Radius.elliptical(border_top_right_radius.x, value);
        break;
      case 3:
        border_top_right_radius =
            Radius.elliptical(value, border_top_right_radius.y);
        break;
      case 4:
        border_bottom_right_radius =
            Radius.elliptical(value, border_bottom_right_radius.y);
        break;
      case 5:
        border_bottom_right_radius =
            Radius.elliptical(border_bottom_right_radius.x, value);
        break;
      case 6:
        border_bottom_left_radius =
            Radius.elliptical(border_bottom_left_radius.x, value);
        break;
      case 7:
        border_bottom_left_radius =
            Radius.elliptical(value, border_bottom_left_radius.y);
        break;
    }
  }

  double operator [](int index) {
    switch (index) {
      case 0:
        return border_top_left_radius.x;
      case 1:
        return border_top_left_radius.y;
      case 2:
        return border_top_right_radius.y;
      case 3:
        return border_top_right_radius.x;
      case 4:
        return border_bottom_right_radius.x;
      case 5:
        return border_bottom_right_radius.y;
      case 6:
        return border_bottom_left_radius.y;
      case 7:
        return border_bottom_left_radius.x;
    }
  }

  String get cssString => """
border-top-left-radius:${border_top_left_radius.x}px / ${border_top_left_radius
      .y}px;
border-top-right-radius:${border_top_right_radius
      .x}px / ${border_top_right_radius.y}px;
border-bottom-right-radius:${border_bottom_right_radius
      .x}px / ${border_bottom_right_radius.y}px;
border-bottom-left-radius:${border_bottom_left_radius
      .x}px / ${border_bottom_left_radius.y}px;
""";

  BorderRadius get borderRadius => BorderRadius.only(
    topLeft: border_top_left_radius,
    topRight: border_top_right_radius,
    bottomRight: border_bottom_right_radius,
    bottomLeft: border_bottom_left_radius,
  );
}

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
  Radius border_top_left_radius = Radius.zero;
  Radius border_top_right_radius = Radius.zero;
  Radius border_bottom_right_radius = Radius.zero;
  Radius border_bottom_left_radius = Radius.zero;

  List<Function> controllerActions;
  List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(8, (i){
      final controller = TextEditingController();
      controller.addListener((){
        controllerActions[i](double.tryParse(controller.text)??0.0);
      });
      return controller;
    },growable: false);
    controllerActions = [
    (r)=>setState((){border_top_left_radius = Radius.elliptical(r,border_top_left_radius.y);}),
    (r)=>setState((){border_top_left_radius = Radius.elliptical(border_top_left_radius.x,r);}),
    (r)=>setState((){{border_top_right_radius = Radius.elliptical(border_top_right_radius.x,r);}}),
    (r)=>setState((){border_top_right_radius = Radius.elliptical(r,border_top_right_radius.y);}),
    (r)=>setState((){border_bottom_right_radius=Radius.elliptical(r,border_bottom_right_radius.y);}),
    (r)=>setState((){border_bottom_right_radius=Radius.elliptical(border_bottom_right_radius.x, r);}),
    (r)=>setState((){{border_bottom_left_radius=Radius.elliptical(border_bottom_left_radius.x, r);}}),
    (r)=>setState((){{border_bottom_left_radius=Radius.elliptical(r, border_bottom_left_radius.y);}}),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final css = """
border-top-left-radius:${border_top_left_radius.x}px / ${border_top_left_radius.y}px;
border-top-right-radius:${border_top_right_radius.x}px / ${border_top_right_radius.y}px;
border-bottom-right-radius:${border_bottom_right_radius.x}px / ${border_bottom_right_radius.y}px;
border-bottom-left-radius:${border_bottom_left_radius.x}px / ${border_bottom_left_radius.y}px;
""";
    final edits = controllers.map((c)=>SizedBox(
      width: 60,
      height: 40,
      child: TextField(
        controller: c,
        decoration: InputDecoration(border: OutlineInputBorder()),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
        ),
      ),
    )).toList();

    return Column(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  edits[1],
                  edits[2]
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      edits[0],
                      edits[7]
                    ],
                  ),
                ),
               Container(
                 width: 200,
                 height: 200,
                 child:  Container(
                   margin: EdgeInsets.all(2),
                   decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.only(
                       topLeft: border_top_left_radius,
                       topRight: border_top_right_radius,
                       bottomRight: border_bottom_right_radius,
                       bottomLeft: border_bottom_left_radius,
                     ),
                   ),
                 ),
               ),
                SizedBox(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      edits[3],
                      edits[4]
                    ],
                  ),
                ),
              ],
            ),
           SizedBox(
             width: 200,
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
                 edits[6],
                 edits[5]
               ],
             ),
           ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: SelectableText(css),
        )
      ],
    );
  }
}

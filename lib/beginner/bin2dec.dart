import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fixnum/fixnum.dart' show Int32;

class Bin2Dec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bin2Dec'),
      ),
      body: Bin2DecPage(),
    );
  }
}

class Bin2DecPage extends StatefulWidget {
  @override
  _Bin2DecPageState createState() => _Bin2DecPageState();
}

class _Bin2DecPageState extends State<Bin2DecPage> {
  String bin = '';

  void _input(int value){
    setState(() {
      bin = '$bin$value';
    });
  }

  void _delete(){
    if(bin.length>0){
      setState(() {
        bin = bin.substring(0,bin.length-1);
      });
    }
  }

  void _clear(){
    setState(() {
      bin = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('BIN:'),
        Expanded(
          child: Text(bin),
        ),
        Text("DEC:"),
        Expanded(
          child: Text(
              (bin.length == 0) ? '0' : BigInt.parse(bin, radix: 2).toString()),
        ),
        SizedBox(
          height: 80,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Icon(Icons.backspace),
                  onPressed: _delete,
                  onLongPress: _clear,
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Text('0'),
                  onPressed: (){_input(0);},
                ),
              ),
              Expanded(
                child: FlatButton(
                  child: Text('1'),
                  onPressed: (){_input(1);},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fixnum/fixnum.dart' show Int32;

class Bin2Dec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bin2Dec'),
      ),
      body: CalculatorWidget(),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalculatorState();
  }
}

class _CalculatorState extends State<CalculatorWidget> {
  var decValue = Int32(0);
  int mode = 10;

  static const int deleteValue = -1;
  static const int oppositeValue = -2;
  final enabledTextStyle = TextStyle(color: Colors.black);
  final disabledTextStyle = TextStyle(color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(),
            child: NumberRow(
              label: 'DEC',
              value: decValue.toString(),
              enabled: mode == 10,
            ),
          ),
          onTap: () {
            if (mode != 10) {
              setState(() {
                mode = 10;
              });
            }
          },
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(),
            child: NumberRow(
              label: 'BIN',
              value: decValue.toRadixString(2),
              enabled: mode == 2,
            ),
          ),
          onTap: () {
            if (mode != 2) {
              setState(() {
                mode = 2;
              });
            }
          },
        ),
        buttonRow(7, 8, 9),
        buttonRow(4, 5, 6),
        buttonRow(1, 2, 3),
        buttonRow(oppositeValue, 0, deleteValue),
      ],
    );
  }

  void handleDecInput(int value) {
    if (value == deleteValue) {
      if (this.decValue == 0) return;
      setState(() {
        this.decValue = this.decValue ~/ 10;
      });
    } else if (value == oppositeValue) {
      setState(() {
        this.decValue = -this.decValue;
      });
    } else {
      setState(() {
        this.decValue = this.decValue * 10 + value;
      });
    }
  }

  void handleBinInput(int value) {
    if (value == deleteValue) {
      if (decValue == 0) return;
      setState(() {
        this.decValue = this.decValue >> 1;
      });
    } else if (value == oppositeValue) {
      setState(() {
        this.decValue = -this.decValue;
      });
    } else {
      setState(() {
        this.decValue = (this.decValue << 1) + value;
      });
    }
  }

  Widget buttonRow(int v1, int v2, int v3) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            child: createButtons(v1),
          ),
          Expanded(
            child: createButtons(v2),
          ),
          Expanded(
            child: createButtons(v3),
          )
        ],
      ),
    );
  }

  Widget createButtons(
    int inputValue,
  ) {
    var buttonEnabled;
    var text;
    if (inputValue == deleteValue) {
      buttonEnabled = true;
      text = 'DEL';
    } else if (inputValue == oppositeValue) {
      buttonEnabled = true;
      text = '+/-';
    } else if (mode == 10) {
      buttonEnabled = true;
      text = inputValue.toString();
    } else {
      buttonEnabled = inputValue < 2;
      text = inputValue.toString();
    }
    return FlatButton(
      child: Center(
        child: Text(
          text,
          style: buttonEnabled ? enabledTextStyle : disabledTextStyle,
        ),
      ),
      onPressed: () {
        if (!buttonEnabled) return;
        if (mode == 10) {
          handleDecInput(inputValue);
        } else {
          handleBinInput(inputValue);
        }
      },
      onLongPress: () {
        if (inputValue == deleteValue) {
          setState(() {
            decValue = Int32(0);
          });
        }
      },
    );
  }
}

class NumberRow extends StatelessWidget {
  String label;
  String value;
  bool enabled;

  final enabledTextStyle = TextStyle(color: Colors.blueAccent);
  final disabledTextStyle = TextStyle(color: Colors.black);

  NumberRow({Key key, this.label, this.value, this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label),
        Text(
          value,
          style: this.enabled ? enabledTextStyle : disabledTextStyle,
        )
      ],
    );
  }
}

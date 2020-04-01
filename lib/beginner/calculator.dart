import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: CalculatorWidget(),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  static const int opNone = 10;
  static const int opPlus = opNone + 1;
  static const int opMinus = opPlus + 1;
  static const int opTimes = opMinus + 1;
  static const int opDivid = opTimes + 1;
  static const int opDot = opDivid + 1;
  static const int opOpposite = opDot + 1;
  static const int opResult = opOpposite + 1;
  static const int opC = opResult + 1;
  static const int opAC = opC + 1;
  String digitsLast;
  String digitsInput;
  String digitsShow = '0';
  int operator = opNone;
  int cOrAcOperate = opAC;
  TextStyle numberStyle = TextStyle(color: Colors.black);
  TextStyle operatorStyle = TextStyle(color: Colors.orange);
  bool hasOpResult = false;

  void onInput(int digit) {
    if (digit < 10) {
      if (hasOpResult) {
        cOrAcOperate = opAC;
        onOp(opC);
        hasOpResult = false;
      }
      setState(() {
        if (digitsInput == null || digitsInput == '0') {
          digitsInput = digit.toString();
          digitsShow = digitsInput ?? '0';
        } else {
          digitsInput += digit.toString();
          digitsShow = digitsInput ?? '0';
        }
        cOrAcOperate = opC;
      });
    } else {
      onOp(digit);
    }
  }

  void onOp(int op) {
    switch (op) {
      case opC:
        if (cOrAcOperate == opC) {
          setState(() {
            digitsInput = null;
            digitsShow = '0';
            cOrAcOperate = opAC;
          });
        } else {
          setState(() {
            digitsInput = null;
            digitsLast = null;
            digitsShow = '0';
            operator = opNone;
          });
        }
        break;
      case opResult:
        if (digitsLast != null) {
          hasOpResult = true;
          setState(() {
            cOrAcOperate = opAC;
            digitsShow =
                doOperate(BigInt.parse(digitsLast), BigInt.parse(digitsInput))
                    .toString();
            digitsLast = digitsShow;
          });
        }
        break;
      case opDot:
        if(digitsInput == null){
          digitsInput = '0.';
          setState(() {
            digitsShow = digitsInput;
          });
        }else if (!digitsInput.contains('.')){
          digitsInput += '.';
          setState(() {
            digitsShow = digitsInput;
          });
        }
        break;
      case opOpposite:
        if(digitsInput!=null && digitsInput!='0'){
          if(digitsInput.startsWith('-')){
            digitsInput = digitsInput.substring(1,digitsInput.length);
          }else{
            digitsInput = '-$digitsInput';
          }
          setState(() {
            digitsShow = digitsInput;
          });
        }
        break;
      default:
        if (operator == opNone) {
          digitsLast = digitsInput;
          digitsInput = null;
          setState(() {
            digitsShow = '0';
          });
        }
        operator = op;
        break;
    }
  }

  BigInt doOperate(BigInt n1, BigInt n2) {
    switch (operator) {
      case opPlus:
        return n1 + n2;
      case opMinus:
        return n1 - n2;
      case opTimes:
        return n1 * n2;
      case opDivid:
        return BigInt.from(n1 / n2);
    }
  }

  Widget _createButton(int digit) {
    return Expanded(
      child: FlatButton(
        child: _digit2Widget(digit),
        onPressed: () {
          onInput(digit);
        },
      ),
    );
  }

  Widget _digit2Widget(int digit) {
    switch (digit) {
      case opPlus:
        return Text('+', style: operatorStyle);
      case opMinus:
        return Text('-', style: operatorStyle);
      case opTimes:
        return Text('×', style: operatorStyle);
      case opDivid:
        return Text('÷', style: operatorStyle);
      case opOpposite:
        return Text('+/-', style: operatorStyle);
      case opC:
        return Text((cOrAcOperate == opC) ? 'C' : 'AC', style: operatorStyle);
      case opResult:
        return Text('=', style: operatorStyle);
      case opDot:
        return Text('.', style: numberStyle);
      default:
        return Text(digit.toString(), style: numberStyle);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rowHeight = 80.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(digitsShow),
          ),
        ),
        SizedBox(
          height: rowHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _createButton(opC),
              _createButton(opOpposite),
              _createButton(opDivid),
              _createButton(opTimes)
            ],
          ),
        ),
        SizedBox(
          height: rowHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _createButton(7),
              _createButton(8),
              _createButton(9),
              _createButton(opMinus),
            ],
          ),
        ),
        SizedBox(
          height: rowHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _createButton(4),
              _createButton(5),
              _createButton(6),
              _createButton(opPlus),
            ],
          ),
        ),
        SizedBox(
          height: rowHeight * 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _createButton(1),
                          _createButton(2),
                          _createButton(3),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: FlatButton(
                              child: Text(
                                '0',
                                style: numberStyle,
                              ),
                              onPressed: () {
                                onInput(0);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: FlatButton(
                              child: Text(
                                '.',
                                style: numberStyle,
                              ),
                              onPressed: () {
                                onInput(opDot);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    width: rowHeight,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                        '=',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  onTap: () {
                    onInput(opResult);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basic Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF121212),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final FocusNode _firstFocusNode = FocusNode();
  final FocusNode _secondFocusNode = FocusNode();

  String _result = '';

  void _calculate(String operation) {
    final num1 = double.tryParse(_firstController.text);
    final num2 = double.tryParse(_secondController.text);

    if (num1 == null || num2 == null) {
      setState(() {
        _result = 'Invalid input!';
      });
      return;
    }

    if (operation == 'divide' && num2 == 0) {
      setState(() {
        _result = 'Cannot divide by zero';
      });
      return;
    }

    double res = 0;
    switch (operation) {
      case 'add':
        res = num1 + num2;
        break;
      case 'subtract':
        res = num1 - num2;
        break;
      case 'multiply':
        res = num1 * num2;
        break;
      case 'divide':
        res = num1 / num2;
        break;
      case 'modulo':
        res = num1 % num2;
        break;
    }

    setState(() {
      _result = 'Result: $res';
    });
  }

  void _clear() {
    _firstController.clear();
    _secondController.clear();
    setState(() {
      _result = '';
    });
  }

  void _appendInput(String input) {
    if (_firstFocusNode.hasFocus) {
      _firstController.text += input;
    } else if (_secondFocusNode.hasFocus) {
      _secondController.text += input;
    }
  }

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    super.dispose();
  }

  String _getButtonLabel(int index) {
    switch (index) {
      case 0:
        return '+';
      case 1:
        return '-';
      case 2:
        return '×';
      case 3:
        return '÷';
      case 4:
        return '%';
      case 5:
        return 'C';
      case 6:
        return '=';
      case 7:
        return '1';
      case 8:
        return '2';
      case 9:
        return '3';
      case 10:
        return '4';
      case 11:
        return '5';
      case 12:
        return '6';
      case 13:
        return '7';
      case 14:
        return '8';
      case 15:
        return '9';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Basic Calculator',
          style: TextStyle(color: Colors.yellowAccent, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                _result.isEmpty ? 'Enter numbers' : _result,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextField(
                      controller: _firstController,
                      focusNode: _firstFocusNode,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        labelText: 'First Number',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _secondController,
                      focusNode: _secondFocusNode,
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        labelText: 'Second Number',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    switch (index) {
                      case 0:
                        _calculate('add');
                        break;
                      case 1:
                        _calculate('subtract');
                        break;
                      case 2:
                        _calculate('multiply');
                        break;
                      case 3:
                        _calculate('divide');
                        break;
                      case 4:
                        _calculate('modulo');
                        break;
                      case 5:
                        _clear();
                        break;
                      case 6:
                        // Optional: Equal
                        break;
                      default:
                        _appendInput(_getButtonLabel(index));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20), backgroundColor: Colors.grey[850],
                    shape: CircleBorder(),
                  ),
                  child: Text(
                    _getButtonLabel(index),
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

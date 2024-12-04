import 'package:flutter/material.dart';

class InputPanel extends StatefulWidget {
  final VoidCallback onSave;
  final ValueChanged<double> onAmountChanged;

  const InputPanel(
      {super.key, required this.onSave, required this.onAmountChanged});

  @override
  InputPanelState createState() => InputPanelState();
}

class InputPanelState extends State<InputPanel> {
  String _currentExpression = '';
  String _amount = '0';
  String _lastResult = '0';

  void _addToExpression(String input) {
    setState(() {
      if (input == '+' || input == '-') {
        if (_currentExpression.isNotEmpty &&
            !_currentExpression.endsWith('+') &&
            !_currentExpression.endsWith('-')) {
          _currentExpression += input;
        } else if (_currentExpression.isEmpty) {
          _currentExpression = _lastResult + input;
        }
      } else {
        if (_currentExpression == '0') {
          _currentExpression = input;
        } else {
          _currentExpression += input;
        }
      }
      _updateAmount();
    });
  }

  void _deleteLast() {
    setState(() {
      if (_currentExpression.isNotEmpty) {
        _currentExpression =
            _currentExpression.substring(0, _currentExpression.length - 1);
        if (_currentExpression.isEmpty) {
          _currentExpression = '0';
        }
      }
      _updateAmount();
    });
  }

  void _updateAmount() {
    try {
      final expression =
          _currentExpression.replaceAll('+', ' + ').replaceAll('-', ' - ');
      final tokens = expression.split(' ');
      double result = double.parse(tokens[0]);

      for (int i = 1; i < tokens.length; i += 2) {
        final operator = tokens[i];
        final value = double.parse(tokens[i + 1]);
        if (operator == '+') {
          result += value;
        } else if (operator == '-') {
          result -= value;
        }
      }

      _amount = result.toStringAsFixed(2);
      _lastResult = _amount;
      widget.onAmountChanged(result);
    } catch (e) {
      _amount = _lastResult;
    }
  }

  void _clear() {
    setState(() {
      _currentExpression = '0';
      _amount = '0';
      _lastResult = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: '备注...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Text(
                _amount,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                final buttons = [
                  '1',
                  '2',
                  '3',
                  '删除',
                  '4',
                  '5',
                  '6',
                  '-',
                  '7',
                  '8',
                  '9',
                  '+',
                  '再记',
                  '0',
                  '.',
                  '保存',
                ];
                final button = buttons[index];

                return GestureDetector(
                  onTap: () {
                    if (button == '删除') {
                      _deleteLast();
                    } else if (button == '+' || button == '-') {
                      _addToExpression(button);
                    } else if (button == '再记') {
                      _clear();
                    } else if (button == '保存') {
                      widget.onSave();
                    } else {
                      _addToExpression(button);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: button == '保存'
                          ? Colors.red
                          : button == '再记'
                              ? Colors.grey
                              : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        button,
                        style: TextStyle(
                          color: button == '保存' || button == '再记'
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

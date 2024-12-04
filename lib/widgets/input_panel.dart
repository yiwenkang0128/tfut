import 'package:flutter/material.dart';

class InputPanel extends StatefulWidget {
  final VoidCallback onSave;
  final ValueChanged<double> onAmountChanged;
  final ValueChanged<DateTime> onDateChanged;

  const InputPanel({
    super.key,
    required this.onSave,
    required this.onAmountChanged,
    required this.onDateChanged,
  });

  @override
  InputPanelState createState() => InputPanelState();
}

class InputPanelState extends State<InputPanel> {
  String _currentExpression = '';
  String _amount = '0';
  String _lastResult = '0';
  DateTime _selectedDate = DateTime.now();

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000), // Set the minimum date
      lastDate: DateTime(2100), // Set the maximum date
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.onDateChanged(pickedDate);
      });
    }
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
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  textAlign: TextAlign.right,
                  _amount,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                  'Add New',
                  '0',
                  '.',
                  'Save',
                ];
                final button = buttons[index];

                return GestureDetector(
                  onTap: () {
                    if (button == '删除') {
                      _deleteLast();
                    } else if (button == '+' || button == '-') {
                      _addToExpression(button);
                    } else if (button == 'Add New') {
                      _clear();
                    } else if (button == 'Save') {
                      widget.onSave();
                    } else {
                      _addToExpression(button);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: button == 'Save'
                          ? Colors.red
                          : button == 'Add New'
                              ? Colors.grey
                              : Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        button,
                        style: TextStyle(
                          color: button == 'Save' || button == 'Add New'
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

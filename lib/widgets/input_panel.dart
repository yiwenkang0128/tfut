import 'package:flutter/material.dart';

class InputPanel extends StatefulWidget {
  final VoidCallback onSave;

  InputPanel({required this.onSave});

  @override
  _InputPanelState createState() => _InputPanelState();
}

class _InputPanelState extends State<InputPanel> {
  String _currentExpression = ''; // 当前计算表达式
  String _amount = '0'; // 当前金额结果
  String _lastResult = '0'; // 上一个结果

  // 添加数字或符号到计算表达式
  void _addToExpression(String input) {
    setState(() {
      if (input == '+' || input == '-') {
        // 如果是运算符，确保当前表达式有效并以数字结尾
        if (_currentExpression.isNotEmpty &&
            !_currentExpression.endsWith('+') &&
            !_currentExpression.endsWith('-')) {
          _currentExpression += input;
        } else if (_currentExpression.isEmpty) {
          // 如果当前表达式为空，则用上一个结果作为起点
          _currentExpression = _lastResult + input;
        }
      } else {
        if (_currentExpression == '0') {
          _currentExpression = input; // 初始为0时，替换
        } else {
          _currentExpression += input; // 否则追加数字
        }
      }
      _updateAmount(); // 更新金额结果
    });
  }

  // 删除最后一个字符
  void _deleteLast() {
    setState(() {
      if (_currentExpression.isNotEmpty) {
        _currentExpression =
            _currentExpression.substring(0, _currentExpression.length - 1);
        if (_currentExpression.isEmpty) {
          _currentExpression = '0'; // 清空后重置为0
        }
      }
      _updateAmount(); // 更新金额结果
    });
  }

  // 更新金额结果，仅显示计算结果
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

      _amount = result.toStringAsFixed(2); // 显示两位小数
      _lastResult = _amount; // 更新上一个结果
    } catch (e) {
      _amount = _lastResult; // 遇到错误时保持上一个结果
    }
  }

  // 清空表达式和结果
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
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          // 第一行：输入框和金额显示
          Row(
            children: [
              Expanded(
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
                _amount, // 显示计算结果或上一个结果
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // 第二行：计算器
          Expanded(
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 四列
                childAspectRatio: 2.5, // 高宽比
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
                    margin: EdgeInsets.all(4.0),
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

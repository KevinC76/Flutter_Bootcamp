import 'dart:math';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:ibmi/widgets/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMIPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BMIPageState();
  }
}

class _BMIPageState extends State<BMIPage> {
  double? _deviceHeight, _deviceWidth;

  int _age = 25, _weight = 160, _height = 70, _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Center(
      child: CupertinoPageScaffold(
        child: Container(
            height: _deviceHeight! * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ageSelecContainer(),
                    _weightSelectContainer(),
                  ],
                ),
                _heightSelectContainer(),
                _genderSelectContainer(),
                _calculateBMIButton(),
              ],
            )),
      ),
    );
  }

  Widget _ageSelecContainer() {
    return InfoCard(
      height: _deviceHeight! * 0.20,
      width: _deviceWidth! * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Age yr",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _age.toString(),
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                key: Key('age_minus'),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    if (_age > 0) _age--;
                  });
                },
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
              ),
              CupertinoButton(
                key: Key('age_plus'),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _age++;
                  });
                },
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _weightSelectContainer() {
    return InfoCard(
      height: _deviceHeight! * 0.20,
      width: _deviceWidth! * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Weight lbs",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _weight.toString(),
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                key: const Key('weight_minus'),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    if (_weight > 0) _weight--;
                  });
                },
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
              ),
              CupertinoButton(
                key: const Key('weight_plus'),
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _weight++;
                  });
                },
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _heightSelectContainer() {
    return InfoCard(
      height: _deviceHeight! * 0.18,
      width: _deviceWidth! * 0.90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Height in',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _height.toString(),
            style: const TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: _deviceWidth! * 0.80,
            child: CupertinoSlider(
              min: 0,
              max: 96,
              divisions: 96,
              value: _height.toDouble(),
              onChanged: (_value) {
                setState(
                  () {
                    _height = _value.toInt();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _genderSelectContainer() {
    return InfoCard(
        height: _deviceHeight! * 0.11,
        width: _deviceWidth! * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Gender',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            CupertinoSlidingSegmentedControl(
              groupValue: _gender,
              children: const {
                0: Text('Male'),
                1: Text('Female'),
              },
              onValueChanged: (_value) {
                setState(() {
                  _gender = _value as int;
                });
              },
            )
          ],
        ));
  }

  Widget _calculateBMIButton() {
    return Container(
      height: _deviceHeight! * 0.06,
      child: CupertinoButton.filled(
        key: Key('calculate_button'),
        child: const Text('Calculate BMI'),
        onPressed: () {
          if (_height > 0 && _weight > 0 && _age > 0) {
            double _bmi = calculatorBMI(_height, _weight);
            _showResultDialog(_bmi);
          }
        },
      ),
    );
  }

  void _showResultDialog(double _bmi) {
    String? _status;
    if (_bmi < 18.5) {
      _status = 'Underweight';
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _status = 'Normal';
    } else if (_bmi >= 25 && _bmi < 30) {
      _status = 'Overweight';
    } else {
      _status = 'Obese';
    }

    showCupertinoDialog(
      context: context,
      builder: (BuildContext _context) {
        return CupertinoAlertDialog(
          title: Text(_status!),
          content: Text(
            _bmi.toStringAsFixed(2),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                _saveResult(_bmi.toStringAsFixed(2), _status!);
                Navigator.pop(_context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _saveResult(String _bmi, String _status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'bmi_date',
      DateTime.now().toString(),
    );
    await prefs.setStringList(
      'bmi_data',
      <String>[
        _bmi,
        _status,
      ],
    );
    // print("result saved!");
    developer.log("\x1B[32mResult Saved!\x1B[0m");
  }
}

import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _level = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TitleText(),
              _SliderWidget(),
              _StartButton(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _TitleText() {
    return Column(
      children: [
        Text(
          'Frivia',
          style: TextStyle(color: Colors.white, fontSize: 48),
        ),
        Text(
          '${_level == 0 ? 'Easy' : _level == 1 ? 'Medium' : 'Hard'}',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

  Widget _StartButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return GamePage(
              difficulty:
                  '${_level == 0 ? 'easy' : _level == 1 ? 'medium' : 'hard'}');
        }));
      },
      child: Text(
        'Start Button',
        style: TextStyle(fontSize: 24),
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
      ),
    );
  }

  Widget _SliderWidget() {
    return Slider(
      value: _level.toDouble(),
      onChanged: (newRange) {
        setState(() => _level = newRange.toInt());
      },
      min: 0,
      max: 2,
      divisions: 2,
    );
  }
}

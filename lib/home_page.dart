import 'package:flutter/material.dart';
import 'package:fribia_app/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double _currentDifficultyLevel = 0;

  final List<String> _difficultyTexts = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.10,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                _appTittle(),
                _difficultySlider(),
                _startGameButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTittle() {
    return Column(
      children: [
        const Text(
          'Frivia',
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficultyTexts[_currentDifficultyLevel.toInt()],
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
      label: "${_difficultyTexts[_currentDifficultyLevel.toInt()]} Difficulty",
      min: 0,
      max: 2,
      divisions: 2,
      value: _currentDifficultyLevel,
      onChanged: (_value) {
        setState(() {
          _currentDifficultyLevel = _value;
          // print(_currentDifficultyLevel);
        });
      },
      activeColor: Colors.blue,
    );
  }

  Widget _startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return GamePage(difficultyLevel: _difficultyTexts[_currentDifficultyLevel.toInt()].toLowerCase(),);
            },
          ),
        );
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: const Text(
        "Start",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

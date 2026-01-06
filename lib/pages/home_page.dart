import 'package:flutter/material.dart';
import 'package:frivia_app/pages/game_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? deviceHeight, deviceWidth;
  double difficultyLevel = 0;
  final List<String> difficultyText = ['Easy', 'Medium', 'Hard'];
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [apptitle(), difficultySlider(), startGameButton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget apptitle() {
    return Column(
      children: [
        Text(
          'Frivia',
          style: TextStyle(
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          difficultyText[difficultyLevel.toInt()],
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }

  Widget difficultySlider() {
    return Slider(
      min: 0,
      max: 2,
      divisions: 3,
      value: difficultyLevel,
      onChanged: (double value) {
        setState(() {
          difficultyLevel = value;
        });
      },
    );
  }

  Widget startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return GamePage(
                difficulty: difficultyText[difficultyLevel.toInt()]
                    .toLowerCase(),
              );
            },
          ),
        );
      },
      color: Colors.deepPurple,
      minWidth: deviceWidth! * 0.5,
      height: deviceHeight! * 0.07,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Text(
        'Start Game',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

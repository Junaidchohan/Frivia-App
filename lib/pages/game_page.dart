import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  double? deviceHeight, deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return buildUI();
  }

  Widget buildUI() {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.05),
          child: gameUI(),
        ),
      ),
    );
  }

  Widget gameUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        questionText(),
        Column(
          children: [
            trueButton(),
            SizedBox(height: deviceHeight! * 0.01),
            falseButton(),
          ],
        ),
      ],
    );
  }

  Widget questionText() {
    return Text(
      'Sample Question?',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.green,
      minWidth: deviceWidth! * 0.4,
      height: deviceHeight! * 0.06,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        'True',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget falseButton() {
    return MaterialButton(
      onPressed: () {},
      color: Colors.red,
      minWidth: deviceWidth! * 0.4,
      height: deviceHeight! * 0.06,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        'False',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

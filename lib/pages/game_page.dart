import 'package:flutter/material.dart';
import 'package:frivia_app/provider/game_page_provider.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double? deviceHeight, deviceWidth;

  GamePageProvider? gamePageProvider;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context),
      child: buildUI(),
    );
  }

  Widget buildUI() {
    return Builder(
      builder: (context) {
        gamePageProvider = Provider.of<GamePageProvider>(context);
        if (gamePageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth! * 0.05),
                child: gameUI(),
              ),
            ),
          );
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
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
      gamePageProvider!.getCurrentQuestion().toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget trueButton() {
    return MaterialButton(
      onPressed: () => gamePageProvider!.answerQuestion('True'),
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
      onPressed: () => gamePageProvider!.answerQuestion('False'),
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

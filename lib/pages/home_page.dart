import 'package:flutter/material.dart';

import '../pages/game_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _headingText(),
              _startButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headingText() {
    return Center(
      child: Text(
        'Qrivia',
        style: TextStyle(
          fontSize: 80,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _startButton(BuildContext ctx) {
    return MaterialButton(
      color: Colors.blue,
      onPressed: () {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => GamePage(),
          ),
        );
      },
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.1,
      child: Text(
        'Start',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
        ),
      ),
    );
  }
}

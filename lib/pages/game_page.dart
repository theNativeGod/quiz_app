import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../provider/game_page_provider.dart';

import '../models/question.dart';

import '../widgets/answer_button.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GamePageProvider? _pageProvider;

  double? _deviceHeight, _deviceWidth;

  MediaQueryData? _mediaQueryData;

  Question? _question;

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_context) => GamePageProvider(
        context: context,
      ),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _pageProvider = _context.watch<GamePageProvider>();
      if (_pageProvider!.questions != null) {
        _question = _pageProvider!.getQuestion();
        return Scaffold(
          body: SafeArea(
            child: Container(
              height: _deviceHeight,
              width: _deviceWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: _deviceHeight! * 0.05,
                  vertical: _deviceHeight! * 0.05),
              child: _gamePageUI(),
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  Widget _gamePageUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionNoAndTypeDisp(),
        _questionText(),
        _answerButton(),
        _categoryAndDifficultyDisp(),
      ],
    );
  }

  Widget _questionText() {
    return FittedBox(
      child: Html(
        data: _question!.questionText,
        style: {
          "h1": Style(
            backgroundColor: Colors.white,
            color: Colors.white,
          ),
          "p": Style(
            //border: Border(bottom: BorderSide(color: Colors.grey)),

            fontSize: FontSize.larger,
            color: Colors.white,
          ),
          "body": Style(
            fontSize: FontSize((_deviceWidth! -
                    (_mediaQueryData!.padding.left +
                        _mediaQueryData!.padding.right)) /
                15),
            color: Colors.white,
          ),
        },
      ),
    );
    /*Text( 
     (_question!.questionText),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
      ),
    );*/
  }

  Widget _answerButton() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ..._question!.options.map((option) {
            return AnswerButton(optionText: option as String);
          }),
        ]);
  }

  Widget _questionNoAndTypeDisp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          (_pageProvider!.currentIndex + 1).toString(),
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 25,
          ),
        ),
        Text(
          'Type: ${_question!.type}',
          style: const TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ],
    );
  }

  Widget _categoryAndDifficultyDisp() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Category: ${_question!.category}',
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 25,
          ),
        ),
        Text(
          'Difficulty: ${_question!.difficulty}',
          style: const TextStyle(color: Colors.blue, fontSize: 25),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

import '../provider/game_page_provider.dart';

class AnswerButton extends StatelessWidget {
  String optionText;
  double? _deviceHeight, _deviceWidth;
  AnswerButton({required this.optionText, super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final provider = Provider.of<GamePageProvider>(context, listen: false);
    return MaterialButton(
      onPressed: () {
        provider.checkAnswerAndAddScore(optionText);
      },
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.05,
      color: Colors.blue,
      child: Html(data: optionText, style: {
        "body": Style(
          fontSize: FontSize(25),
        )
      }),
    );
  }
}

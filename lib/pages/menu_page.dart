import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/menu_provider.dart';

import '../widgets/dropdown_widget.dart';

class MenuPage extends StatelessWidget {
  double? _deviceHeight, _deviceWidth;

  MenuProvider _menuProvider = MenuProvider();
  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (ctx) => MenuProvider(),
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(builder: (_context) {
      _menuProvider = _context.watch<MenuProvider>();

      if (_menuProvider.categoryWithIdList != null) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                height: _deviceHeight! * 0.9,
                width: _deviceWidth! * 0.8,
                margin: EdgeInsets.symmetric(
                  horizontal: _deviceWidth! * 0.05,
                  vertical: _deviceHeight! * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _headingText(),
                    _typeDropdown(),
                    _difficultyDropdown(),
                  ],
                ),
              ),
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

  Widget _headingText() {
    return Center(
      child: Text(
        'Menu',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _typeDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Type',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        DropdownWidget(
          menuList: [
            'Any',
            'Multiple Choice',
            'Boolean',
          ],
        ),
      ],
    );
  }

  Widget _difficultyDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Difficulty',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        DropdownWidget(
          menuList: [
            'Any',
            'Easy',
            'Medium',
            'Hard',
          ],
        ),
      ],
    );
  }
}

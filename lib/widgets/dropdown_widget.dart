import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> menuList;

  final double fontSize;

  String _currentlySelectedItem = 'Any';

  DropdownWidget({required this.menuList, this.fontSize = 25, super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: widget.menuList.map((String menuListItem) {
        return DropdownMenuItem<String>(
          value: menuListItem,
          child: Text(
            menuListItem,
            textAlign: TextAlign.right,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        widget._currentlySelectedItem = newValue!;
        setState(() {});
      },
      value: widget._currentlySelectedItem,
      // hint: Text(_currentlySelectedItem),
      underline: Container(),
      dropdownColor: Color.fromRGBO(
        31,
        31,
        31,
        1.0,
      ),
      iconEnabledColor: Colors.blue,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'ArchitectsDaughter',
        fontSize: widget.fontSize,
      ),
      alignment: Alignment.centerRight,
    );
  }
}

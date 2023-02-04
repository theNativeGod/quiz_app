import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MenuProvider with ChangeNotifier {
  String? difficulty;
  String? type;
  int? categoryId;

  List categoryWithIdList = [];

  List categoryList = [];

  Dio _dio = Dio();

  MenuProvider() {
    _getCategoriesFromAPI();
  }

  Future<void> _getCategoriesFromAPI() async {
    var _response = await _dio.get('https://opentdb.com/api_category.php');

    var _data = jsonDecode(_response.toString());
    categoryWithIdList = _data["trivia_categories"];
    _getCategoryList();
    notifyListeners();
  }

  void _getCategoryList() {
    for (int i = 0; i < categoryWithIdList.length; i++) {
      categoryList.add(categoryWithIdList[i]['name']);
    }
    notifyListeners();
  }

  void getCategoryIdFromName(String categoryName) {
    int index = categoryWithIdList
        .indexWhere((element) => element['name'] == categoryName);
    categoryId = categoryWithIdList[index]['id'];
  }

  void setDifficulty(String? str) {
    difficulty = str;
  }

  void setType(String? str) {
    type = str;
  }

  void setCategory(String? str) {
    if (str != null) {
      getCategoryIdFromName(str);
    } else {
      categoryId = null;
    }
  }
}

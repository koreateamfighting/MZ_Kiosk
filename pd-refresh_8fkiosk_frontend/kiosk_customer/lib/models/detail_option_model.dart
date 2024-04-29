import 'dart:convert';
import 'package:flutter/services.dart';

class DetailOptionModel {
  String title;
  List<CheckboxOptions> options;

  DetailOptionModel({
    required this.title,
    required this.options,
  });

  activeCondition(int index) {
    for (var i = 0; i < options.length; i++) {
      if (i == index) {
        options[i].checked = true;
      } else {
        options[i].checked = false;
      }
    }
  }

  // DetailOptionListModel.fromJson(Map<String, dynamic> json)
  //     : title = json['title'],
  //       options = json['options'];

  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': title,
  //     'options': options,
  //   };
  // }

  // String get getName => name;
  // String get getVendor => vendor;
  // String get getPlatform => platform;
  // String get getEnviron => environ;
  // String get getEngine => engine;

  // void setMode(String value) => mode = value;
  // void setEngine(String value) => engine = value;
}

class CheckboxOptions {
  String label;
  bool checked;

  CheckboxOptions({
    required this.label,
    required this.checked,
  });
}

class JsonParser {
  String convertCategory(int category) {
    late String categoryString;
    switch (category) {
      case 0:
        categoryString = "coffee";
        break;
      case 1:
        categoryString = "milk";
        break;
      case 2:
        categoryString = "ade";
        break;
      case 3:
        categoryString = "sparkling_and_juice";
        break;
      case 4:
        categoryString = "tea";
        break;
      case 5:
        categoryString = "ramen";
        break;
      case 6:
        categoryString = "rice";
        break;
      case 7:
        categoryString = "salad";
        break;
      case 8:
        categoryString = "bread";
        break;
      case 9:
        categoryString = "dessert";
        break;
      default:
        categoryString = "";
        break;
    }
    return categoryString;
  }

  Future<List<DetailOptionModel>> getOptionList(String key) async {
    String data =
        await rootBundle.loadString('assets/json/category_options.json');
    Map<String, dynamic> jsonData = json.decode(data);

    List<DetailOptionModel> menuList = [];

    try {
      if (jsonData.containsKey(key)) {
        for (var optionList in jsonData[key]) {
          List<CheckboxOptions> options = [];
          for (var option in optionList['options']) {
            options.add(CheckboxOptions(
              label: option['label'],
              checked: option['checked'],
            ));
          }

          menuList.add(DetailOptionModel(
            title: optionList['title'],
            options: options,
          ));
        }
      }
      return menuList;
    } catch (err) {
      print(err);
      return [];
    }
  }
}

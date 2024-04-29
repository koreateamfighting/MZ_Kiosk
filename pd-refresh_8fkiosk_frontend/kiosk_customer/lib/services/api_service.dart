// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kiosk_customer/models/cafe_menu_list_model.dart';
import 'package:kiosk_customer/models/final_result_model.dart';
import 'package:kiosk_customer/models/order_list_model.dart';

class ApiService {
  static const String baseUrl = "https://pdrf.mediazenaicloud.com:36402";

  static Future<List<CafeMenuListModel>> getMenuInfo(int category) async {
    String convertCategory(int category) {
      String ret = "";
      switch (category) {
        case 0:
          ret = 'Menulist_coffee';
          break;
        case 1:
          ret = 'Menulist_milk';
          break;
        case 2:
          ret = 'Menulist_ade';
          break;
        case 3:
          ret = 'Menulist_sparkling_and_juice';
          break;
        case 4:
          ret = 'Menulist_tea';
          break;
        case 5:
          ret = 'Menulist_ramen';
          break;
        case 6:
          ret = 'Menulist_rice';
          break;
        case 7:
          ret = 'Menulist_salad';
          break;
        case 8:
          ret = 'Menulist_bread';
          break;
        case 9:
          ret = 'Menulist_dessert';
          break;
        default:
          ret = 'Menulist_all';
          break;
      }
      return ret;
    }

    List<CafeMenuListModel> cafeMenuInstances = [];
    String reqMethod = convertCategory(category);

    final url = Uri.parse('$baseUrl/$reqMethod');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> cafeMenus = jsonDecode(response.body);

      for (var cafeMenu in cafeMenus) {
        cafeMenuInstances.add(CafeMenuListModel.fromJson(cafeMenu));
      }
      return cafeMenuInstances;
    } else {
      print('loading');
    }
    throw Error();
  }

  static Future<List<FinalResultModel>> isValidUser(String qrdata) async {
    List<FinalResultModel> userInfos = [];
    String reqMethod = 'Valid_user';
    final url = Uri.parse('$baseUrl/$reqMethod/$qrdata');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> tmp = jsonDecode(response.body);
      if (tmp.isNotEmpty) {
        userInfos.add(FinalResultModel.fromJson(tmp[0]));
      }
    } else {
      print('loading');
    }
    return userInfos;
  }

  static Future<void> updateOrder(
      int empno, List<OrderListModel> orderList) async {
    String reqMethod = 'AddOrder';
    String orderParam = '';
    List<OrderListModel> tmpOrderList = [];

    // 10개를 강제로 채우기 위한 처리
    for (int i = 0; i < orderList.length; i++) {
      tmpOrderList.add(orderList[i]);
    }
    for (int i = orderList.length; i < 10; i++) {
      tmpOrderList.add(OrderListModel(
        name: '_',
        options: '_',
        id: 0,
        price: 0,
        count: 0,
      ));
    }

    for (int i = 0; i < tmpOrderList.length; i++) {
      orderParam +=
          '/${tmpOrderList[i].id}/${tmpOrderList[i].count}/${tmpOrderList[i].options}';
    }

    await http.post(
      Uri.parse('$baseUrl/$reqMethod/${empno.toString()}$orderParam'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<dynamic, dynamic>{
        "empno": empno,
        "order_list1_id": tmpOrderList[0].id,
        "order_list1_each": tmpOrderList[0].count,
        "order_list1_options": tmpOrderList[0].options,
        "order_list2_id": tmpOrderList[1].id,
        "order_list2_each": tmpOrderList[1].count,
        "order_list2_options": tmpOrderList[1].options,
        "order_list3_id": tmpOrderList[2].id,
        "order_list3_each": tmpOrderList[2].count,
        "order_list3_options": tmpOrderList[2].options,
        "order_list4_id": tmpOrderList[3].id,
        "order_list4_each": tmpOrderList[3].count,
        "order_list4_options": tmpOrderList[3].options,
        "order_list5_id": tmpOrderList[4].id,
        "order_list5_each": tmpOrderList[4].count,
        "order_list5_options": tmpOrderList[4].options,
        "order_list6_id": tmpOrderList[5].id,
        "order_list6_each": tmpOrderList[5].count,
        "order_list6_options": tmpOrderList[5].options,
        "order_list7_id": tmpOrderList[6].id,
        "order_list7_each": tmpOrderList[6].count,
        "order_list7_options": tmpOrderList[6].options,
        "order_list8_id": tmpOrderList[7].id,
        "order_list8_each": tmpOrderList[7].count,
        "order_list8_options": tmpOrderList[7].options,
        "order_list9_id": tmpOrderList[8].id,
        "order_list9_each": tmpOrderList[8].count,
        "order_list9_options": tmpOrderList[8].options,
        "order_list10_id": tmpOrderList[9].id,
        "order_list10_each": tmpOrderList[9].count,
        "order_list10_options": tmpOrderList[9].options,
      }),
    );
  }
}

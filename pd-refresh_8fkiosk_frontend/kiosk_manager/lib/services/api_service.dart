// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kiosk_manager/models/daily_sales_model.dart';
import 'package:kiosk_manager/models/order_list_model.dart';

class ApiService {
  static const String baseUrl = "https://pdrf.mediazenaicloud.com:36402";

  static Future<List<OrderListModel>> getOrderList() async {
    List<OrderListModel> orderListInstances = [];
    String reqMethod = 'Orderlist';

    final url = Uri.parse('$baseUrl/$reqMethod');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> orderList = jsonDecode(response.body);

      for (var order in orderList) {
        orderListInstances.add(OrderListModel.fromJson(order));
      }
      return orderListInstances;
    } else {
      return orderListInstances;
    }
  }

  static Future<bool> updateOrderStatus(String number, status) async {
    String reqMethod = 'Order_status';
    final url = Uri.parse('$baseUrl/$reqMethod/$number/$status');

    try {
      final response = await http.put(url);
      if (response.statusCode == 200) {
        print('주문 상태 변경 성공');
        return true;
      } else {
        print('주문 상태 변경 실패');
        return false;
      }
    } catch (error) {
      print('오류 발생: $error');
      return false;
    }
  }

  static Future<List<DailySalesModel>> getDailySales(String date) async {
    List<DailySalesModel> dailySalesInstances = [];
    if (date.isEmpty) {
      return dailySalesInstances;
    }
    String reqMethod = 'Search_daily';

    final url = Uri.parse('$baseUrl/$reqMethod/$date');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> salesItems = jsonDecode(response.body);

      for (var salesItem in salesItems) {
        if (salesItem['상품명'] != '_') {
          print(salesItem['상품명']);
          dailySalesInstances.add(DailySalesModel.fromJson(salesItem));
        }
      }
      return dailySalesInstances;
    } else {
      return dailySalesInstances;
    }
  }
}

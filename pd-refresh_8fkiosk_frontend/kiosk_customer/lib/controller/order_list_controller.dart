import 'package:get/get.dart';
import '../models/order_list_model.dart';

class OrderListController extends GetxController {
  dynamic orders = <OrderListModel>[].obs;

  void addOrder(OrderListModel order) {
    bool unique = true;
    for (int i = 0; i < orders.length; i++) {
      if (orders[i].name == order.name && orders[i].options == order.options) {
        orders[i].count += order.count;
        unique = false;
        orders.refresh();
        break;
      }
    }
    if (unique) {
      orders.add(order);
    }
  }

  void removeOrder(idx) {
    orders.removeAt(idx);
  }

  void clearOrderList() {
    orders.clear();
  }

  List<OrderListModel> getAllOrdersList() {
    return orders;
  }

  String getName(idx) {
    return orders[idx].name;
  }

  String getOptions(idx) {
    return orders[idx].options;
  }

  int getId(idx) {
    return orders[idx].id;
  }

  int getPrice(idx) {
    return orders[idx].price;
  }

  int getCount(idx) {
    return orders[idx].count;
  }

  int getAllOrdersCount() {
    return orders.length;
  }

  void increaseCount(idx) {
    if (orders[idx].count < 99) {
      orders[idx].count++;
      orders.refresh();
    }
  }

  void decreaseCount(idx) {
    if (orders[idx].count > 1) {
      orders[idx].count--;
      orders.refresh();
    } else {
      removeOrder(idx);
    }
  }

  int getAllCount() {
    int total = 0;
    for (OrderListModel order in orders) {
      total += order.count;
    }
    return total;
  }

  int getAllPrice() {
    int total = 0;
    for (OrderListModel order in orders) {
      total += order.price * order.count;
    }
    return total;
  }
}

class DetailOrderList {
  String name, option, count;

  DetailOrderList({
    required this.name,
    required this.option,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'option': option,
      'count': count,
    };
  }
}

class OrderListModel {
  String orderNumber, orderTime, ename, team, grade;
  int empno, orderStatus, totalPrice;
  List<DetailOrderList> orderList;
  int totalCount = 0;

  OrderListModel({
    required this.orderNumber,
    required this.orderTime,
    required this.ename,
    required this.team,
    required this.grade,
    required this.empno,
    required this.orderStatus,
    required this.totalPrice,
    required this.orderList,
  });

  OrderListModel.fromJson(Map<String, dynamic> json)
      : orderNumber = json['order_number'],
        orderTime = json['order_time'],
        empno = json['empno'],
        ename = json['ename'],
        team = json['team'],
        grade = json['grade'],
        orderStatus = json['order_status'],
        orderList = parseDetailOrderList(json['total_order_list']),
        totalPrice = json['total_price'];

  int getTotalCount() {
    totalCount = 0;
    for (var order in orderList) {
      totalCount += int.parse(order.count);
    }
    return totalCount;
  }
}

List<DetailOrderList> parseDetailOrderList(String input) {
  List<DetailOrderList> result = [];
  List<String> values = input.split('\t');

  for (int i = 0; i < values.length - 3; i += 3) {
    String name = values[i];
    if (name == '_') {
      break;
    }
    String option = values[i + 1];
    if (option == '_') {
      option = '';
    }
    String count = values[i + 2];

    result.add(DetailOrderList(
      name: name,
      option: option,
      count: count,
    ));
  }

  return result;
}

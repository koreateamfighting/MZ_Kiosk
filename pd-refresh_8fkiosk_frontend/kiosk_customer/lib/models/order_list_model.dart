class OrderListModel {
  String name, options;
  int id, price, count;

  OrderListModel({
    required this.name,
    required this.options,
    required this.id,
    required this.price,
    required this.count,
  });

  OrderListModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        options = json['options'],
        id = json['id'],
        price = json['price'],
        count = json['count'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'options': options,
      'id': id,
      'price': price,
      'count': count,
    };
  }
}

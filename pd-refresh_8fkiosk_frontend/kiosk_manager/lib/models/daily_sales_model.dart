class DailySalesModel {
  String name, count;

  DailySalesModel({
    required this.name,
    required this.count,
  });

  DailySalesModel.fromJson(Map<String, dynamic> json)
      : name = json['상품명'],
        count = json['판매수'];
}

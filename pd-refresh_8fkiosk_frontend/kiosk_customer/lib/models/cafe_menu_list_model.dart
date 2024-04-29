class CafeMenuListModel {
  final String? cafeFoodName, imagePath; //, description;
  final int? category, price, foodId;
  final bool? saleStatus, discount;

  CafeMenuListModel.fromJson(Map<dynamic, dynamic> json)
      : cafeFoodName = json['food_name'],
        category = json['category'],
        price = json['price'],
        saleStatus = json['sale_status'],
        discount = json['discount_available'],
        imagePath = json['image_path'],
        foodId = json['food_id']; //,
  //description = json['Description'];
}

class FinalResultModel {
  String userId, userName, userTeam, userGrade, userMothlyUsage, orderNumber;
  int userNum;

  FinalResultModel({
    required this.userNum,
    required this.userId,
    required this.userName,
    required this.userTeam,
    required this.userGrade,
    required this.userMothlyUsage,
    required this.orderNumber,
  });

  FinalResultModel.fromJson(Map<String, dynamic> json)
      : userNum = json['empno'],
        userId = json['user_id'],
        userName = json['ename'],
        userTeam = json['team'],
        userGrade = json['grade'],
        userMothlyUsage = json['this_month_usage'],
        orderNumber = json['order_number'];
}

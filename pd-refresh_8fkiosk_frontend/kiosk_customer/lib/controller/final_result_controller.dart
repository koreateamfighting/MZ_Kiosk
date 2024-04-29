import 'package:get/get.dart';
import '../models/final_result_model.dart';

class FinalResultController extends GetxController {
  dynamic finalResult = <FinalResultModel>[].obs;

  void setFinalResult(FinalResultModel result) {
    finalResult = result;
  }

  int getNum() {
    return finalResult.userNum;
  }

  String getName() {
    return finalResult.userName;
  }

  String getId() {
    return finalResult.userId;
  }

  String getTeam() {
    return finalResult.userTeam;
  }

  String getGrade() {
    return finalResult.userGrade;
  }

  int getMothlyUsage() {
    return int.parse(finalResult.userMothlyUsage);
  }

  int getOrderNumber() {
    return int.parse(finalResult.orderNumber);
  }
}

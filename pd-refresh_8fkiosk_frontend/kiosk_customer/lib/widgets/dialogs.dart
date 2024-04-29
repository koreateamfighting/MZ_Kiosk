import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_customer/controller/final_result_controller.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';
import 'package:kiosk_customer/models/final_result_model.dart';
import 'package:kiosk_customer/services/api_service.dart';

class Dialogs {
  static void showYesNoDialog(
      BuildContext context, String message, bool moveHome) async {
    final OrderListController orderlistcontroller =
        Get.put(OrderListController());
    double defaultIconSize = MediaQuery.of(context).size.width * 0.06;
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
          ),
          backgroundColor: const Color(0xffb69275),
          content: Container(
            width: 740,
            height: 462,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: 740,
                    height: 462,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 740,
                            height: 462,
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(
                                0.5,
                              ),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFDD2626),
                                ),
                              ),
                            ),
                            child: Container(),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 13.44,
                          child: Container(
                            width: 716,
                            height: 434.09,
                            decoration: const ShapeDecoration(
                              color: Color(0xffb69275),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFDD2626),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          top: 150, //202.39,
                          child: Column(
                            children: [
                              Text(
                                message,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 34,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: const ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(1.00, 0.00),
                                        end: Alignment(-1, 0),
                                        colors: [
                                          Color(0xFF768AD2),
                                          Color(0xFF212029),
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 6.50,
                                          color: Color(0xFFB28484),
                                        ),
                                      ),
                                    ),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        orderlistcontroller.clearOrderList();
                                        Navigator.of(context).pop();
                                        if (moveHome) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.touch_app_outlined,
                                            size: defaultIconSize,
                                            color: const Color(0xFFFFD233),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          const Text(
                                            '네',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 85,
                                  ),
                                  Container(
                                    decoration: const ShapeDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(1.00, 0.00),
                                        end: Alignment(-1, 0),
                                        colors: [
                                          Color(0xFFD240C3),
                                          Color(0xFF351F23)
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 6.50,
                                          color: Color(0xFFB28484),
                                        ),
                                      ),
                                    ),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.touch_app_outlined,
                                            size: defaultIconSize,
                                            color: const Color(0xFFFFD233),
                                          ),
                                          const Text(
                                            '아니요',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 38,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showErrorDialog(BuildContext context, String message) async {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10.0,
              ),
            ),
          ),
          backgroundColor: const Color(0xffffe43d),
          content: Container(
            width: 740,
            height: 462,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: 740,
                    height: 462,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 12,
                          top: 13.44,
                          child: Container(
                            width: 716,
                            height: 434.09,
                            decoration: const ShapeDecoration(
                              color: Color(0xffffe43d),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFDD2626),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 100,
                          top: 202.39,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.warning_amber,
                                size: 80.0,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                message,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 34,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showQrAuthDialog(BuildContext context) async {
    final OrderListController orderlistcontroller =
        Get.put(OrderListController());
    final FinalResultController finalresultcontroller =
        Get.put(FinalResultController());
    TextEditingController qrValue = TextEditingController();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          backgroundColor: const Color(0xffb69275),
          content: Container(
            width: 740,
            height: 462,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: 740,
                    height: 462,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 740,
                            height: 462,
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.5),
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFDD2626),
                                ),
                              ),
                            ),
                            child: TextField(
                                style: const TextStyle(
                                  fontSize: 5,
                                  height: 1,
                                  color: Colors.white,
                                ),
                                autofocus: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(5),
                                ),
                                showCursor: false,
                                controller: qrValue,
                                onChanged: (text) {
                                  Future.delayed(
                                      const Duration(milliseconds: 500),
                                      () async {
                                    //간혹 10자리미만이하로 짤려 나오는 데이터가 나오는 경우가 있어 , 10자리 이상 나올때에 유효함으로 판단
                                    if (qrValue.text.length > 10) {
                                      List<FinalResultModel> userInfo =
                                          await ApiService.isValidUser(
                                              qrValue.text);
                                      qrValue.clear();
                                      if (userInfo.isEmpty) {
                                        showQrErrorDialog(context,
                                            'QR Code 인증에 실패하였습니다.\n다시 시도해주세요.');
                                      } else {
                                        finalresultcontroller
                                            .setFinalResult(userInfo[0]);
                                        showFinalResultDialog(context);
                                        ApiService.updateOrder(
                                            finalresultcontroller.getNum(),
                                            orderlistcontroller
                                                .getAllOrdersList());
                                      }
                                    }
                                  });
                                }),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 13.44,
                          child: Container(
                            width: 716,
                            height: 434.09,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFB69275),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  color: Color(0xFFDD2626),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 100,
                          top: 160,
                          child: Row(
                            children: [
                              Icon(
                                Icons.qr_code_scanner,
                                size: 80.0,
                                color: Color.fromARGB(255, 92, 62, 52),
                              ),
                              SizedBox(width: 30),
                              Text(
                                '상단 카메라에\nQR Code 코드를 인증해 주세요',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 34,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showQrErrorDialog(BuildContext context, String message) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          showQrAuthDialog(context);
        });

        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          backgroundColor: const Color(0xffffe43d),
          content: Container(
              width: 740,
              height: 462,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                          width: 740,
                          height: 462,
                          child: Stack(children: [
                            Positioned(
                              left: 12,
                              top: 13.44,
                              child: Container(
                                width: 716,
                                height: 434.09,
                                decoration: const ShapeDecoration(
                                  color: Color(0xffffe43d),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFFDD2626)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                left: 100,
                                top: 162.39,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.warning_amber,
                                      size: 80.0,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      message,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 34,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )),
                          ])))
                ],
              )),
        );
      },
    );
  }

  static void showFinalResultDialog(BuildContext context) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    var dt = DateTime.now();
    final OrderListController orderlistcontroller =
        Get.put(OrderListController());
    final FinalResultController finalresultcontroller =
        Get.put(FinalResultController());

    mergeTotalUsage() {
      int total = orderlistcontroller.getAllPrice() +
          finalresultcontroller.getMothlyUsage();
      return total.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 7), () {
          Navigator.of(context).pop();
          orderlistcontroller.clearOrderList();
        });
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xFF965E32),
            ),
          ),
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.33,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 8,
                  child: Column(
                    children: [
                      Text(
                        '주문 내역',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '주문번호 ${(finalresultcontroller.getOrderNumber() + 1).toString()}',
                              style: TextStyle(
                                color: const Color(0xFF0B23FB),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                            const SizedBox(),
                          ]),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            for (var order
                                in orderlistcontroller.getAllOrdersList())
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${order.name}  ${order.options}',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                    ),
                                  ),
                                  Text(
                                    order.count.toString(),
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '총 수량: ${orderlistcontroller.getAllCount()}개',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '총 금액: ${orderlistcontroller.getAllPrice().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Color(0xFF965E32),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${finalresultcontroller.getName()} ${finalresultcontroller.getGrade()}님, ',
                                style: TextStyle(
                                  color: const Color(0xFF0B23FB),
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.025,
                                ),
                              ),
                              TextSpan(
                                  text: '주문 결제가 완료되었습니다.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.025,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${dt.month}월 총 사용 금액 : ${mergeTotalUsage()}원',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';
import 'package:get/get.dart';
import 'package:kiosk_customer/widgets/order_list_widget.dart';
import 'package:kiosk_customer/widgets/dialogs.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final OrderListController orderlistcontroller =
      Get.put(OrderListController());

  var dt = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  _showErrEmptyMsgDialog(int btnType) {
    String errTxt = '';
    if (btnType == 1) {
      errTxt = '주문한 내역이 없습니다.';
    }
    if (btnType == 2) {
      errTxt = '주문 취소할 내역이 없습니다.';
    }

    Dialogs.showErrorDialog(context, errTxt);
  }

  @override
  Widget build(BuildContext context) {
    double defaultFontSize = MediaQuery.of(context).size.width * 0.02;
    double buttonFontSize = MediaQuery.of(context).size.width * 0.04;
    double defaultPaddingSize = MediaQuery.of(context).size.width * 0.01;
    double defaultIconSize = MediaQuery.of(context).size.width * 0.06;
    bool isEmpty = false;
    int btnType = 0;

    /// 1: 결제 2: 취소

    return GetX<OrderListController>(
      builder: (controller) {
        return Column(
          children: [
            Flexible(
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFB28484),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.all(defaultPaddingSize),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFEDECEC),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '주문 내역',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: defaultFontSize,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: controller.orders.length,
                                  itemBuilder: (context, index) {
                                    return OrderList(
                                      controller: controller,
                                      index: index,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: defaultPaddingSize,
                              right: defaultPaddingSize,
                              bottom: defaultPaddingSize),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xFF3E5EB2),
                                        Color(0xFF0A132B),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: defaultPaddingSize * 4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '총 수량: ${controller.getAllCount()}개',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: defaultFontSize,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '총 금액: ${controller.getAllPrice().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: defaultFontSize,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFF3E5EB2),
                                      Color(0xFF0A132B),
                                    ],
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (orderlistcontroller.orders.length < 1) {
                                      isEmpty = true;
                                      btnType = 1;
                                    } else {
                                      isEmpty = false;
                                      btnType = 0;
                                    }
                                    isEmpty
                                        ? _showErrEmptyMsgDialog(btnType)
                                        : Dialogs.showQrAuthDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.30,
                                      MediaQuery.of(context).size.height * 0.06,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.touch_app_outlined,
                                        size: defaultIconSize,
                                        color: const Color(0xFFFFD233),
                                      ),
                                      Text(
                                        '결제 하기',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: buttonFontSize,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFFB2533E),
                                      Color(0xFF605252),
                                    ],
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (orderlistcontroller.orders.length < 1) {
                                      isEmpty = true;
                                      btnType = 2;
                                    } else {
                                      isEmpty = false;
                                      btnType = 0;
                                    }
                                    isEmpty
                                        ? _showErrEmptyMsgDialog(btnType)
                                        : Dialogs.showYesNoDialog(context,
                                            '선택하신 주문을 모두 취소할까요?', false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(
                                      MediaQuery.of(context).size.width * 0.30,
                                      MediaQuery.of(context).size.height * 0.06,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cancel_outlined,
                                        size: defaultIconSize,
                                        color: const Color(0xFFFD0000),
                                      ),
                                      Text(
                                        '주문 취소',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: buttonFontSize,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF670808),
                      Color(0xFF605252),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

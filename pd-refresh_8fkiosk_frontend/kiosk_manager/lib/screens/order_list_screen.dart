import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kiosk_manager/models/order_list_model.dart';
import 'package:kiosk_manager/services/api_service.dart';
import 'package:kiosk_manager/services/websocket_service.dart';
import 'package:web_socket_channel/io.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late IOWebSocketChannel _channel;
  final ScrollController _scrollController = ScrollController();
  Future<List<OrderListModel>>? orderListFuture;
  bool? updateStatusResult;
  List<int> selectedStatus = [0, 2];

  @override
  void initState() {
    super.initState();
    orderListFuture = ApiService.getOrderList();

    _channel =
        IOWebSocketChannel.connect('wss://pdrf.mediazenaicloud.com:36402');
    _listenWebSocket();
  }

  void _listenWebSocket() {
    _channel.stream.listen((data) {
      Map<String, dynamic> jsonData = json.decode(data);
      switch (jsonData['content']) {
        case 'GetNewOrder':
          setState(() {
            orderListFuture = ApiService.getOrderList();
          });
          break;
        default:
          break;
      }
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    double itemWidth = MediaQuery.of(context).size.width;
    double viewportWidth = MediaQuery.of(context).size.width;
    final double distanceToMove = itemWidth * 1.8 - viewportWidth;
    setState(() {
      if (details.primaryDelta! > 0) {
        _scrollController.animateTo(
          _scrollController.offset - distanceToMove,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (details.primaryDelta! < 0) {
        _scrollController.animateTo(
          _scrollController.offset + distanceToMove,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        /* Nothing Todo */
      }
    });
  }

  void toggleStatus(int value) {
    setState(() {
      if (selectedStatus.contains(value)) {
        selectedStatus.remove(value);
      } else {
        selectedStatus.add(value);
      }
    });
  }

  void updateStaus(String number, String status) async {
    updateStatusResult = await ApiService.updateOrderStatus(number, status);
    if (updateStatusResult!) {
      setState(() {
        orderListFuture = ApiService.getOrderList();
      });
    }
  }

  List<OrderListModel> arrangeOrderList(List<OrderListModel> original) {
    List<OrderListModel> result = [];
    for (var status in selectedStatus) {
      for (var order in original) {
        if (order.orderStatus == status) {
          result.add(order);
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderListModel>>(
      future: orderListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Column(
            children: [
              _buildHeader(),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                ),
                child: const Text(
                  '주문 목록을 불러오는 중 오류가 발생했습니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          final orderList = arrangeOrderList(snapshot.data!);
          if (orderList.isEmpty) {
            return Column(
              children: [
                _buildHeader(),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: const Text(
                    '현재 조건에 맞는 주문 내역이 존재하지 않습니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                WebSocketService(channel: _channel),
                _buildOrderList(orderList),
                _buildPaginationButtons(),
              ],
            );
          }
        } else {
          return Column(
            children: [
              _buildHeader(),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.4,
                ),
                child: const Text(
                  '서버 요청 중 오류가 발생했습니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.home_outlined,
            size: 42,
          ),
        ),
        const Text(
          '홈 / 주문 내역',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const Spacer(),
        const Text(
          '화면 필터 설정  ',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF605252),
          ),
        ),
        GestureDetector(
          onTap: () {
            toggleStatus(0);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              width: 90,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedStatus.contains(0)
                    ? const Color(0xFFFFD233)
                    : const Color(0xFFFFFFFF),
                border: Border.all(
                  width: 2,
                  color: const Color(0xFF965E32),
                ),
              ),
              child: const Text(
                '준비',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            toggleStatus(1);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              width: 90,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedStatus.contains(1)
                    ? const Color(0xFFFFD233)
                    : const Color(0xFFFFFFFF),
                border: Border.all(
                  width: 2,
                  color: const Color(0xFF965E32),
                ),
              ),
              child: const Text(
                '완료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            toggleStatus(2);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              width: 90,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedStatus.contains(2)
                    ? const Color(0xFFFFD233)
                    : const Color(0xFFFFFFFF),
                border: Border.all(
                  width: 2,
                  color: const Color(0xFF965E32),
                ),
              ),
              child: const Text(
                '예약',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            toggleStatus(3);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Container(
              width: 90,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedStatus.contains(3)
                    ? const Color(0xFFFFD233)
                    : const Color(0xFFFFFFFF),
                border: Border.all(
                  width: 2,
                  color: const Color(0xFF965E32),
                ),
              ),
              child: const Text(
                '취소',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderList(List<OrderListModel> orderList) {
    return Expanded(
      child: GestureDetector(
        onHorizontalDragUpdate: _handleDragUpdate,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: orderList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 20,
                right: 50,
              ),
              child: Container(
                width: 900,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: const Color(0xFF7D7B7B),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Text(
                        '주문 번호 ${orderList[index].orderNumber}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                          color: Color(0xFF0B23FB),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                      ),
                      child: Text(
                        '${orderList[index].orderTime}\n사번: ${orderList[index].empno}      이름: ${orderList[index].ename} ${orderList[index].grade} (${orderList[index].team})',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 30,
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 450,
                        height: 1,
                        color: const Color(0xFFE9E9E9),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          for (var order in orderList[index].orderList)
                            Row(
                              children: [
                                Text(
                                  '·${order.name} ${order.option}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 5.0,
                                  ),
                                  child: Container(
                                    width: 40,
                                    // height: 30,
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color(0xFF965E32),
                                    ),
                                    child: Text(
                                      order.count,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26,
                                        color: Color(0xFFFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 360,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 3,
                                color: Color(0xFF7D7B7B),
                              ),
                              right: BorderSide(
                                width: 3,
                                color: Color(0xFF7D7B7B),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '총 수량: ${orderList[index].getTotalCount()}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: 300,
                                  height: 1,
                                  color: const Color(0xFF7D7B7B),
                                ),
                                Text(
                                  '총 금액: ${orderList[index].totalPrice.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (orderList[index].orderStatus != 0) {
                              updateStaus(orderList[index].orderNumber, '0');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              width: 120,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: orderList[index].orderStatus == 0
                                    ? const Color(0xFFFFD233)
                                    : const Color(0xFFFFFFFF),
                                border: Border.all(
                                  width: 4,
                                  color: const Color(0xFF965E32),
                                ),
                              ),
                              child: const Text(
                                '준비',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (orderList[index].orderStatus != 1) {
                              updateStaus(orderList[index].orderNumber, '1');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              width: 120,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: orderList[index].orderStatus == 1
                                    ? const Color(0xFFFFD233)
                                    : const Color(0xFFFFFFFF),
                                border: Border.all(
                                  width: 4,
                                  color: const Color(0xFF965E32),
                                ),
                              ),
                              child: const Text(
                                '완료',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (orderList[index].orderStatus != 2) {
                              updateStaus(orderList[index].orderNumber, '2');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              width: 120,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: orderList[index].orderStatus == 2
                                    ? const Color(0xFFFFD233)
                                    : const Color(0xFFFFFFFF),
                                border: Border.all(
                                  width: 4,
                                  color: const Color(0xFF965E32),
                                ),
                              ),
                              child: const Text(
                                '예약',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (orderList[index].orderStatus != 3) {
                              updateStaus(orderList[index].orderNumber, '3');
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              width: 120,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: orderList[index].orderStatus == 3
                                    ? const Color(0xFFFFD233)
                                    : const Color(0xFFFFFFFF),
                                border: Border.all(
                                  width: 4,
                                  color: const Color(0xFF965E32),
                                ),
                              ),
                              child: const Text(
                                '취소',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(Icons.first_page_sharp),
          iconSize: 74,
          color: const Color(0xFF000000),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.navigate_before_outlined),
          iconSize: 74,
          color: const Color(0xFF000000),
          onPressed: () {
            final double itemWidth = MediaQuery.of(context).size.width * 0.4;
            final double distanceToMove = itemWidth * 1.5;

            _scrollController.animateTo(
              _scrollController.offset - distanceToMove,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.navigate_next_outlined),
          iconSize: 74,
          color: const Color(0xFF000000),
          onPressed: () {
            double itemWidth = MediaQuery.of(context).size.width;
            double viewportWidth = MediaQuery.of(context).size.width;
            final double distanceToMove = itemWidth * 1.5 - viewportWidth;

            _scrollController.animateTo(
              _scrollController.offset + distanceToMove,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.last_page_sharp),
          iconSize: 74,
          color: const Color(0xFF000000),
          onPressed: () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
        ),
      ],
    );
  }

  // @override
  // void dispose() {
  //   // 웹소켓 연결 종료
  //   channel.sink.close();
  //   super.dispose();
  // }
}

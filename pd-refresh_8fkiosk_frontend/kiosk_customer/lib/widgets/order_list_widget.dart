import 'package:flutter/material.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';

class OrderList extends StatelessWidget {
  final int index;
  final OrderListController controller;

  const OrderList({
    super.key,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // print(controller.getOptions(index).length);
    String orderDetail =
        '${controller.getName(index)} ${controller.getOptions(index)}';
    double defaultFontSize = MediaQuery.of(context).size.width * 0.025;
    double defaultIconSize = MediaQuery.of(context).size.width * 0.045;

    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                controller.removeOrder(index);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(3.14159),
                  child: Icon(
                    Icons.backspace_outlined,
                    size: defaultIconSize,
                    color: const Color(0xFFB2533E),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                orderDetail,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: defaultFontSize,
                ),
              ),
            ),
          ),
          // const Spacer(),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      print(index);
                      controller.decreaseCount(index);
                    },
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: defaultIconSize,
                      color: const Color(0xFF3E5EB2),
                    ),
                  ),
                  Text(
                    ' ${controller.getCount(index).toString()} ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: defaultFontSize,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print(index);
                      controller.increaseCount(index);
                    },
                    child: Icon(
                      Icons.add_circle_outline,
                      size: defaultIconSize,
                      color: const Color(0xFF3E5EB2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

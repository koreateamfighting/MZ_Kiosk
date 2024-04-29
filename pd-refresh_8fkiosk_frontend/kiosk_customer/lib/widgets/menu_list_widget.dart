import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_customer/widgets/dialogs.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';
import 'package:kiosk_customer/models/detail_option_model.dart';
import 'package:kiosk_customer/models/order_list_model.dart';
import 'package:kiosk_customer/screen/detail_option_screen.dart';

class Menulist extends StatelessWidget {
  final String cafeFoodName, imagePath; //, description;
  final int category, price, foodId;
  final bool saleStatus, discount;

  const Menulist({
    super.key,
    required this.cafeFoodName,
    required this.imagePath,
    required this.category,
    required this.price,
    required this.saleStatus,
    required this.discount,
    required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    final OrderListController controller = Get.put(OrderListController());
    String tempImage = imagePath;
    tempImage = tempImage.replaceAll(RegExp(r'\s+'), '');
    final Uint8List bytes = base64Decode(tempImage);

    void showDetailOptionScreen(List<DetailOptionModel> options) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailOptionScreen(
            category: category,
            name: cafeFoodName,
            price: price,
            image: imagePath,
            id: foodId,
            options: options,
          ),
        ),
      );
    }

    void selectItem() async {
      JsonParser jsonParser = JsonParser();

      if (controller.getAllOrdersCount() == 10) {
        Dialogs.showErrorDialog(context, '주문리스트는 최대\n10개까지 추가 가능합니다.');
        return;
      }
      List<DetailOptionModel> options =
          await jsonParser.getOptionList(jsonParser.convertCategory(category));
      if (options.isNotEmpty) {
        if (options[0].title == '기본') {
          controller.addOrder(OrderListModel(
            name: cafeFoodName,
            options: '(기본)',
            id: foodId,
            price: price,
            count: 1,
          ));
        } else {
          showDetailOptionScreen(options);
        }
      } else {
        controller.addOrder(OrderListModel(
          name: cafeFoodName,
          options: '',
          id: foodId,
          price: price,
          count: 1,
        ));
      }
    }

    return GestureDetector(
      onTap: () {
        selectItem();
      },
      child: Column(
        children: [
          Hero(
            tag: foodId,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 225,
                height: 240,
                //clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.brown, width: 2),
                ),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.memory(bytes),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      cafeFoodName, // cafeMenu.cafeFoodName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: Color(0xffDADADA),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$price',
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.shopping_cart_outlined,
                              size: 15,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

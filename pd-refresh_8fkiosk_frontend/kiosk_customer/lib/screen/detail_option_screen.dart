import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';
import 'package:kiosk_customer/models/detail_option_model.dart';
import 'package:kiosk_customer/models/order_list_model.dart';
import 'package:kiosk_customer/widgets/detail_option_widget.dart';

class DetailOptionScreen extends StatefulWidget {
  final String name, image;
  final int price, category, id;
  final List<DetailOptionModel> options;

  const DetailOptionScreen({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.options,
    required this.id,
    
  });

  @override
  State<DetailOptionScreen> createState() => _DetailOptionScreenState();
}

class _DetailOptionScreenState extends State<DetailOptionScreen> {
  final OrderListController controller = Get.put(OrderListController());
  late String? name = '', image = '';
  late int? price, category, id;
  late List<DetailOptionModel> options;
  
  int count = 1;

  @override
  void initState() {
    name = widget.name;
    price = widget.price;
    category = widget.category;
    image = widget.image.replaceAll(RegExp(r'\s+'), '');
    options = widget.options;
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultIconSize = MediaQuery.of(context).size.width * 0.06;
    double buttonFontSize = MediaQuery.of(context).size.width * 0.04;

    decreaseCount() {
      if (count > 1) {
        setState(() {
          count--;
        });
      }
    }

    increaseCount() {
      if (count < 100) {
        setState(() {
          count++;
        });
      }
    }

    String finalOption() {
      List<String> results = [];
      for (var big in options) {
        for (var small in big.options) {
          if (small.checked == true) {
            results.add(small.label);
          }
        }
      }
      return results.join(' | ');
    }

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 25,
            fit: FlexFit.tight,
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/appBar.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 4,
                        color: const Color(0xFF965E32),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Image.memory(base64Decode(image!)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                decreaseCount();
                              },
                              child: Icon(
                                Icons.remove_circle_outline,
                                size: defaultIconSize,
                                color: const Color(0xFFCCCCCC),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: Text(
                                count.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                increaseCount();
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                size: defaultIconSize,
                                color: const Color(0xFFCCCCCC),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '총 금액: ${(price! * count).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}원',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 60,
            fit: FlexFit.tight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              // height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return DetailOption(
                    option: options[index],
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 15,
            fit: FlexFit.tight,
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        controller.addOrder(
                          OrderListModel(
                            name: name!,
                            options: '(${finalOption()})',
                            id: id!,
                            price: price!,
                            count: count,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.30,
                          MediaQuery.of(context).size.height * 0.1,
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
                            '옵션 결정',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: buttonFontSize,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 100,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFB2533E),
                          Color(0xFF670808),
                        ],
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                       
                        
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * 0.30,
                          MediaQuery.of(context).size.height * 0.1,
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
        ],
      ),
    );
  }
}

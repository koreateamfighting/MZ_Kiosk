// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:kiosk_customer/models/cafe_menu_list_model.dart';
import 'package:kiosk_customer/services/api_service.dart';
import 'package:kiosk_customer/widgets/menu_list_widget.dart';

class MenuListScreen extends StatefulWidget {
  final int selectedCategory;

  const MenuListScreen({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<MenuListScreen> createState() => _MenuListScreenState();
}

class _MenuListScreenState extends State<MenuListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<CafeMenuListModel>> cafeMenus =
        ApiService.getMenuInfo(widget.selectedCategory);

    return Scaffold(
      body: FutureBuilder(
        future: cafeMenus,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /// separated : separatorBuilder를 사용하여 widget을 반환
            /// makeList 함수 추출
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: makeList(snapshot, widget.selectedCategory),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

GridView makeList(
    AsyncSnapshot<List<CafeMenuListModel>> snapshot, selectedCategory) {
  return GridView.builder(
    itemCount: snapshot.data!.length,
    scrollDirection: Axis.vertical,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      childAspectRatio: 1 / 1,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    itemBuilder: (context, index) {
      var cafeMenus = snapshot.data![index];
      return Menulist(
        cafeFoodName: cafeMenus.cafeFoodName!,
        imagePath: cafeMenus.imagePath!,
        category: cafeMenus.category!,
        price: cafeMenus.price!,
        saleStatus: cafeMenus.saleStatus!,
        discount: cafeMenus.discount!,
        foodId: cafeMenus.foodId!,
      );
    },
  );
}

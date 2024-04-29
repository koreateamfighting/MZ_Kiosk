// ignore_for_file: avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:kiosk_customer/screen/menu_list_screen.dart';
import 'package:kiosk_customer/screen/order_list_screen.dart';
import 'package:kiosk_customer/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:kiosk_customer/controller/order_list_controller.dart';

class MenuChoiceScreen extends StatefulWidget {
  const MenuChoiceScreen({
    super.key,
  });

  @override
  State<MenuChoiceScreen> createState() => _MenuChoiceScreenState();
}

class _MenuChoiceScreenState extends State<MenuChoiceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final OrderListController orderlistcontroller =
      Get.put(OrderListController());
  bool isClick = false;

  //final Future<List<CafeMenuListModel>> cafeMenus = ApiService.getMenuInfo();

  @override
  void initState() {
    _tabController = TabController(length: 10, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    //cafeMenuItem = ApiService.getMenuItemInfo() as Future<CafeMenuItemModel>;
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  _leftBtnSelection() {
    if (_tabController.index > 0 && _tabController.index < 10) {
      _tabController.index = _tabController.index - 1;
    }

    print(_tabController.index);
    print('left');
    _tabController.addListener(_handleTabSelection);
    setState(() {
      isClick = true;
    });
  }

  _rightBtnSelection() {
    try {
      if (_tabController.index < 9) {
        _tabController.index = _tabController.index + 1;
      }
    } finally {
      print('LastPage');
    }
    print(_tabController.index);
    print('right');
    _tabController.addListener(_handleTabSelection);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/appBar.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => Dialogs.showYesNoDialog(
                context, '홈 화면으로 이동하시겠습니까?\n선택하신 주문이 모두 취소됩니다.', true),
          ),
          elevation: 1,
          bottom: PreferredSize(
            preferredSize: const Size.square(60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Icon(
                //   Icons.chevron_left_outlined,
                //   color: Colors.white,
                //   size: 40,
                // ),
                IconButton(
                  onPressed: () {
                    _leftBtnSelection();
                  },
                  icon: const Icon(
                    Icons.chevron_left_outlined,
                    color: Colors.white, //isClick ? Colors.yellow :
                    size: 40,
                  ),
                  padding: const EdgeInsets.only(bottom: 5),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 998,
                  child: TabBar(
                    controller: _tabController,
                    // Customize the appearance and behavior of the tab bar
                    isScrollable: true,
                    //indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 50.0),
                    unselectedLabelColor: Colors.white,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xffF6F6F6),
                            Color(0xffB28787),
                          ]),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      //color: const Color(0xffB28787),
                    ),
                    // Add your tabs here
                    tabs: const [
                      Tab(text: '커피'),
                      Tab(text: '우유'),
                      Tab(text: '에이드'),
                      Tab(text: '탄산/주스'),
                      Tab(text: '차'),
                      Tab(text: '라면'),
                      Tab(text: '밥'),
                      Tab(text: '샐러드'),
                      Tab(text: '빵/샌드위치'),
                      Tab(text: '주전부리'),
                    ],
                  ),
                ),
                // const Icon(
                //   Icons.chevron_right_outlined,
                //   color: Colors.white,
                //   size: 40,
                // ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                  onPressed: () {
                    _rightBtnSelection();
                  }, //_rightBtnSelection(),
                  icon: const Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  padding: const EdgeInsets.only(bottom: 5),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 3,
              child: [
                const MenuListScreen(
                  selectedCategory: 0,
                ),
                const MenuListScreen(
                  selectedCategory: 1,
                ),
                const MenuListScreen(
                  selectedCategory: 2,
                ),
                const MenuListScreen(
                  selectedCategory: 3,
                ),
                const MenuListScreen(
                  selectedCategory: 4,
                ),
                const MenuListScreen(
                  selectedCategory: 5,
                ),
                const MenuListScreen(
                  selectedCategory: 6,
                ),
                const MenuListScreen(
                  selectedCategory: 7,
                ),
                const MenuListScreen(
                  selectedCategory: 8,
                ),
                const MenuListScreen(
                  selectedCategory: 9,
                ),
              ][_tabController.index],
            ),
            const Flexible(
              flex: 1,
              child: OrderListScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

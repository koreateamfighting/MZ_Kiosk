import 'package:flutter/material.dart';
import 'package:kiosk_manager/screens/daily_sales_screen.dart';
import 'package:kiosk_manager/screens/order_list_screen.dart';
import 'package:kiosk_manager/widgets/left_drawer.dart';
import 'package:kiosk_manager/widgets/manager_app_bar.dart';
import 'package:kiosk_manager/widgets/right_drawer.dart';
// import 'package:jinie_builder/screens/splash_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedLeftDrawerIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    OrderListScreen(),
    Text('상품/재고관리 준비중입니다.'),
    Text('기간별 사용내역 준비중입니다.'),
    DailySalesScreen(),
  ];

  void _onLeftDrawerItemTapped(int index) {
    setState(() {
      _selectedLeftDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: const ManagerAppBar(),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 253, 253, 233),
          child: LeftDrawer(
            onLeftDrawerItemTapped: _onLeftDrawerItemTapped,
          ),
        ),
        endDrawer: const Drawer(
          backgroundColor: Color.fromARGB(255, 253, 253, 233),
          child: RightDrawer(),
        ),
        body: _widgetOptions[_selectedLeftDrawerIndex],
      ),
      // home: SplashScreen(
      //   storage: ThemeStorage(),
      // ),
    );
  }
}

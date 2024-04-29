import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  final Function(int) onLeftDrawerItemTapped;

  const LeftDrawer({super.key, required this.onLeftDrawerItemTapped});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 70,
          color: const Color(0xFF243768),
          alignment: Alignment.center,
          child: const Text(
            '사용 메뉴',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.home_outlined,
                  size: 42,
                ),
              ),
              Text(
                '홈 / 주문 내역',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            onLeftDrawerItemTapped(0);
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.trolley,
                  size: 42,
                ),
              ),
              Text(
                '상품 / 재고 관리',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            onLeftDrawerItemTapped(1);
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.calendar_month_outlined,
                  size: 42,
                ),
              ),
              Text(
                '기간별 사용 내역',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            onLeftDrawerItemTapped(2);
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.access_time_outlined,
                  size: 38,
                ),
              ),
              Text(
                '일별 판매 내역',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.pop(context);
            onLeftDrawerItemTapped(3);
          },
        ),
      ],
    );
  }
}

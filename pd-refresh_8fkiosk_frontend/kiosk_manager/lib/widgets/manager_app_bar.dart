import 'package:flutter/material.dart';

class ManagerAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ManagerAppBar({super.key});

  @override
  _ManagerAppBarState createState() => _ManagerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ManagerAppBarState extends State<ManagerAppBar> {
  late String currentTime;

  @override
  void initState() {
    currentTime = _getCurrentTime();
    _updateTime(); // 시작하면 타이머를 시작합니다.
    super.initState();
  }

  String convertedHour(int hour) {
    String ret = '';
    if (hour < 12) {
      ret = '오전 $hour';
    } else if (hour == 12) {
      ret = '오후 $hour';
    } else {
      ret = '오후 ${hour - 12}';
    }
    return ret;
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.year}년 ${now.month}월 ${now.day}일 ${convertedHour(now.hour)}시 ${now.minute}분";
  }

  void _updateTime() {
    setState(() {
      currentTime = _getCurrentTime();
    });

    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 48.0,
            ),
            child: Container(
              width: 140,
              height: 50,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                ),
              ),
            ),
          ),
          const Text(
            '까페테리아 관리자 프로그램',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Spacer(),
        ],
      ),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        iconSize: 32,
        color: Colors.white,
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        Row(
          children: [
            Text(
              currentTime,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 12.0,
              ),
              child: IconButton(
                icon: const Icon(Icons.settings_outlined),
                iconSize: 32,
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ],
      backgroundColor: const Color(0xFF545D72),
    );
  }
}

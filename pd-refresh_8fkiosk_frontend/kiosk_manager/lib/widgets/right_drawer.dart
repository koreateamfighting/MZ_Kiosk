import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiosk_manager/services/api_service.dart';

class RightDrawer extends StatefulWidget {
  const RightDrawer({super.key});

  @override
  State<RightDrawer> createState() => _RightDrawerState();
}

class _RightDrawerState extends State<RightDrawer> {
  @override
  Widget build(BuildContext context) {
    bool isFullscreen = MediaQuery.of(context).viewInsets.bottom == 0;

    return ListView(
      children: [
        Container(
          height: 70,
          color: const Color(0xFF243768),
          alignment: Alignment.center,
          child: const Text(
            '프로그램 메뉴',
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
                  Icons.refresh_outlined,
                  size: 42,
                ),
              ),
              Text(
                '새로고침',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {
            setState(() {
              Navigator.pop(context);
              ApiService.getOrderList();
            });
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.horizontal_rule_outlined,
                  size: 42,
                ),
              ),
              Text(
                '최소화',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: isFullscreen
                    ? const Icon(
                        Icons.fullscreen_exit,
                        size: 42,
                      )
                    : const Icon(
                        Icons.fullscreen,
                        size: 42,
                      ),
              ),
              isFullscreen
                  ? const Text(
                      '창 모드',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )
                  : const Text(
                      '전체화면 모드',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
            ],
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.exit_to_app_outlined,
                  size: 38,
                ),
              ),
              Text(
                '프로그램 종료',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          onTap: () {
            SystemNavigator.pop();
          },
        ),
      ],
    );
  }
}

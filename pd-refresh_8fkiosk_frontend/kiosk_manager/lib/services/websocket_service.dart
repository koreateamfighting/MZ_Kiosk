import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService extends StatelessWidget {
  final IOWebSocketChannel channel;

  const WebSocketService({
    super.key,
    required this.channel,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

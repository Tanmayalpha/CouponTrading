

import 'dart:async';
import 'dart:convert';

import 'package:coupon_trading/Api/api_services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();
  factory WebSocketManager() => _instance;

  WebSocketManager._internal();

  WebSocketChannel? _channel;
  late StreamController _streamController;

  void connect() {
    if (_channel != null) return;// Prevent reconnecting9

    _streamController = StreamController.broadcast();


    _channel = WebSocketChannel.connect(Uri.parse(ApiService.socketUrl));

    _channel!.stream.listen((message) {
      final jsonData = json.decode(message);

      _streamController.add(jsonData);

      // Broadcast this to listeners or use a StreamController to pass to multiple screens
    },
        onError: (error) {
      print('WebSocket error: $error');
    }, onDone: () {
      print('WebSocket closed');
      _channel = null;
    });
  }

  void send(dynamic message) {
    _channel?.sink.add(message);
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  Stream get stream => _streamController.stream;
}

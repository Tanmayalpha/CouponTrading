import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:http/http.dart'as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class MyKChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KChart Candlestick',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: KChartScreen(),
    );
  }
}

class KChartScreen extends StatefulWidget {
  @override
  _KChartScreenState createState() => _KChartScreenState();
}

class _KChartScreenState extends State<KChartScreen> {
  List<KLineEntity> _data = [];
  bool _loading = true;
  MainState _mainState = MainState.MA;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool _showLoading = true;
  WebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _setupWebSocket();
  }

  Future<void> _loadInitialData() async {
    try {
      // Example: Fetch initial data from Binance API
      final response = await http.get(Uri.parse(
          'https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d&limit=100'));

      final jsonData = json.decode(response.body);
      final List<KLineEntity> data = jsonData.map((item) => KLineEntity.fromJson(item)).toList();

      setState(() {
        _data = data;
        _loading = false;
      });
    } catch (e) {
      print('Error loading initial data: $e');
      setState(() => _loading = false);
    }
  }

  void _setupWebSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@kline_1m'),
    );

    _channel!.stream.listen((message) {
      final jsonData = json.decode(message);
      if (jsonData['k'] != null) {
        final kline = jsonData['k'];
        final newEntity = KLineEntity.fromJson({
          'open': double.parse(kline['o']),
          'high': double.parse(kline['h']),
          'low': double.parse(kline['l']),
          'close': double.parse(kline['c']),
          'vol': double.parse(kline['v']),
          'time': kline['t'],
        });

        setState(() {
          // Update or add new candle
          final index = _data.indexWhere((item) => item.time == newEntity.time);
          if (index >= 0) {
            _data[index] = newEntity;
          } else {
            _data.add(newEntity);
            if (_data.length > 200) _data.removeAt(0);
          }
        });
      }
    }, onError: (error) {
      print('WebSocket error: $error');
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BTC/USDT Chart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          _buildChartTypeSelector(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: KChartWidget(
                _data,
                ChartStyle(),ChartColors(),
                mainState: _mainState,
                secondaryState: _secondaryState,
                fixedLength: 2,
                timeFormat: TimeFormat.YEAR_MONTH_DAY,
                onLoadMore: (endTime) => _loadMoreData(),

                maDayList: [5, 10, 20],

                isTrendLine: true,
              ),
            ),
          ),
          _buildTimeFrameSelector(),
        ],
      ),
    );
  }

  Widget _buildChartTypeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildChartTypeButton('MA', MainState.MA),
            _buildChartTypeButton('BOLL', MainState.BOLL),
            _buildChartTypeButton('NONE', MainState.NONE),
            _buildIndicatorButton('MACD', SecondaryState.MACD),
            _buildIndicatorButton('KDJ', SecondaryState.KDJ),
            _buildIndicatorButton('RSI', SecondaryState.RSI),
          ],
        ),
      ),
    );
  }

  Widget _buildChartTypeButton(String text, MainState state) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _mainState == state ? Colors.blue : Colors.grey,
      ),
      onPressed: () => setState(() => _mainState = state),
      child: Text(text, style: TextStyle(fontSize: 12)),
    );
  }

  Widget _buildIndicatorButton(String text, SecondaryState state) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _secondaryState == state ? Colors.blue : Colors.grey,
      ),
      onPressed: () => setState(() => _secondaryState = state),
      child: Text(text, style: TextStyle(fontSize: 12)),
    );
  }

  Widget _buildTimeFrameSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTimeFrameButton('1m', '1m'),
          _buildTimeFrameButton('15m', '15m'),
          _buildTimeFrameButton('1h', '1h'),
          _buildTimeFrameButton('4h', '4h'),
          _buildTimeFrameButton('1d', '1d'),
          _buildTimeFrameButton('1w', '1w'),
        ],
      ),
    );
  }

  Widget _buildTimeFrameButton(String text, String interval) {
    return ElevatedButton(
      onPressed: () => _changeTimeFrame(interval),
      child: Text(text),
    );
  }

  Future<void> _loadMoreData() async {
    setState(() => _showLoading = true);

    try {
      final response = await http.get(Uri.parse(
          'https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1d&endTime=${DateTime.now().subtract(const Duration(days: 5)).millisecondsSinceEpoch}&limit=50'));

      final jsonData = json.decode(response.body);
      final newData = jsonData.map((item) => KLineEntity.fromJson({
        'open': double.parse(item[1]),
        'high': double.parse(item[2]),
        'low': double.parse(item[3]),
        'close': double.parse(item[4]),
        'vol': double.parse(item[5]),
        'time': item[0],
      })).toList();

      setState(() {
        _data.insertAll(0, newData);
        _showLoading = false;
      });
    } catch (e) {
      print('Error loading more data: $e');
      setState(() => _showLoading = false);
    }
  }

  void _changeTimeFrame(String interval) {
    // Implement time frame change logic
    print('Time frame changed to $interval');
    // You would typically reconnect WebSocket with new interval
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chart Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Show MA Lines'),
              trailing: Switch(
                value: _mainState == MainState.MA,
                onChanged: (value) => setState(() {
                  _mainState = value ? MainState.MA : MainState.NONE;
                  Navigator.pop(context);
                }),
              ),
            ),
            ListTile(
              title: const Text('Show Volume'),
              trailing: Switch(
                value: _secondaryState == SecondaryState.WR,
                onChanged: (value) => setState(() {
                  _secondaryState = value ? SecondaryState.WR : SecondaryState.NONE;
                  Navigator.pop(context);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
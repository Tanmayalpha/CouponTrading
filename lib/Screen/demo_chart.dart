import 'dart:convert';
import 'dart:developer';

import 'package:coupon_trading/Model/candel_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:http/http.dart' as http;


class DemoChart extends StatefulWidget {
  const DemoChart({Key? key}) : super(key: key);

  @override
  State<DemoChart> createState() => _DemoChartState();
}



class _DemoChartState extends State<DemoChart> {

  List<KLineEntity>? datas;
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  bool isChinese = true;
  List<DepthEntity>? _bids, _asks;


  @override

  void initState() {
    super.initState();
    getData('1day');
    /*rootBundle.loadString('assets/depth.json').then((result) {
      final parseJson = json.decode(result);
      Map tick = parseJson['tick'];
      var bids = tick['bids']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      var asks = tick['asks']
          .map((item) => DepthEntity(item[0], item[1]))
          .toList()
          .cast<DepthEntity>();
      initDepth(bids, asks);
    });*/

    var date = DateTime.fromMillisecondsSinceEpoch(1663776000 * 1000);
    print("get time: ${DateFormat("dd-MM-yyyy").format(date)}");

  }

  void initDepth(List<DepthEntity> bids, List<DepthEntity> asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids?.sort((left, right) => left.price.compareTo(right.price));
    //累加买入委托量
    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids?.insert(0, item);
    });

    amount = 0.0;
    asks?.sort((left, right) => left.price.compareTo(right.price));
    //累加卖出委托量
    asks?.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks?.add(item);
    });
    setState(() {});
  }

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17212F),
//      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              height: 450,
              width: double.infinity,
              child: KChartWidget(
                datas,
                isLine: isLine,
                mainState: _mainState,
                volHidden: _volHidden,
                secondaryState: _secondaryState,
                chartStyle,
                chartColors,
                fixedLength: 2,
                timeFormat: TimeFormat.YEAR_MONTH_DAY,

                isChinese: isChinese, isTrendLine: true,
              ),
            ),
            if (showLoading)
              Container(
                  width: double.infinity,
                  height: 450,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator()),
          ]),
          buildButtons(),
          /*Container(
            height: 230,
            width: double.infinity,
            child: DepthChart(_bids!, _asks!,chartColors),
          )*/
        ],
      ),
    );
  }


  Widget buildButtons() {
    return Wrap(
      alignment: WrapAlignment.spaceEvenly,
      children: <Widget>[
        button("分时", onPressed: () => isLine = true),
        button("k线", onPressed: () => isLine = false),
        button("MA", onPressed: () => _mainState = MainState.MA),
        button("BOLL", onPressed: () => _mainState = MainState.BOLL),
        button("隐藏", onPressed: () => _mainState = MainState.NONE),
        button("MACD", onPressed: () => _secondaryState = SecondaryState.MACD),
        button("KDJ", onPressed: () => _secondaryState = SecondaryState.KDJ),
        button("RSI", onPressed: () => _secondaryState = SecondaryState.RSI),
        button("WR", onPressed: () => _secondaryState = SecondaryState.WR),
        button("隐藏副视图", onPressed: () => _secondaryState = SecondaryState.NONE),
        button(_volHidden ? "显示成交量" : "隐藏成交量",
            onPressed: () => _volHidden = !_volHidden),
        button("切换中英文", onPressed: () => isChinese = !isChinese),
      ],
    );
  }
  Widget button(String text, {VoidCallback? onPressed}) {
    return ElevatedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
            setState(() {});
          }
        },
        child: Text("$text"),
        );
  }

  void getData(String period) {
    /*Future<String> future = getIPAddress('$period');

    future.then((result) {
      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      DataUtil.calculate(datas!);
      showLoading = false;
      setState(() {});
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('获取数据失败');
    });*/

    Future<String> future = getIPAddress('$period'); //myData();//
    future.then((result) {
      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      DataUtil.calculate(datas!);
      showLoading = false;
      setState(() {});
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('获取数据失败');
    });
  }

  Future<String> myData() async{
    String result = '';
    var headers = {
      'Cookie': 'ci_session=aee89621fdc53ceafa0e31d5f48378699c94d35b'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/coupan-trading/app/v1/api/get_graph_data'));
    request.fields.addAll({
      'coupan_id': ' 1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      result = await response.stream.bytesToString();
      print('___________${result}__________');
    }
    else {
    print(response.reasonPhrase);
    }
    return result ;
  }

  Future<String> getIPAddress(String period) async {
    String result = '';
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=btcusdt';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      result = response.body;
      log(response.body);
    } else {
      print('Failed getting IP address');
    }
    return result;
  }

}

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyLineChart extends StatefulWidget {
  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  List<FlSpot> ecgData = [];
  int dataSize = 50;
  Timer? timer;
  int counter = 0;

  @override
  void initState() {
    super.initState();

    // 开始定时器，每0.3秒添加一个数据点
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        // 计算sin波的值，波幅为±1，周期为5秒
        double value = sin(counter / 8.85 * pi);
        counter++;
        print(counter);

        // 添加数据点到列表
        ecgData.add(FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), value));

        // 只保留过去10秒内的数据
        double now = DateTime.now().millisecondsSinceEpoch.toDouble();
        double past = now - 10000;
        ecgData.removeWhere((spot) => spot.x < past);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 计算波形的X轴范围
    double minX = ecgData.isEmpty ? 0 : ecgData.first.x;
    double maxX = ecgData.isEmpty ? 10000 : ecgData.last.x;

    return Scaffold(
      appBar: AppBar(title: Text('Demo Test'), centerTitle: true),
      body: Row(
        children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: ecgData,
                        isCurved: true, // 将isCurved设置为true
                        curveSmoothness: 0.2, // 调整曲线平滑度
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      show: false,
                      bottomTitles: AxisTitles(
                        // sideTitles: SideTitles(showTitles: false),
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 10,
                          interval: 1,
                        ),
                      ),
                      // leftTitles: SideTitles(
                      //   showTitles: true,
                      //   reservedSize: 35,
                      //
                      // ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: true),
                    minX: minX,
                    maxX: maxX,
                    minY: -1.2,
                    maxY: 1.2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

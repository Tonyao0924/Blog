import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:linechart_demotest/titleData.dart';

class LineChartSample10 extends StatefulWidget {
  const LineChartSample10({super.key});

  final Color sinColor = AppColors.contentColorBlue;

  @override
  State<LineChartSample10> createState() => _LineChartSample10State();
}

class _LineChartSample10State extends State<LineChartSample10> {
  final int limitCount = 35;
  late List<double> st = List.generate(11, (index) => 0.0);
  late List<List<FlSpot>> sinPoints = List.generate(11, (index) => <FlSpot>[]);
  late List<bool> isPlaying = List<bool>.filled(11, false);

  late List<Timer?> timers = List.generate(11, (index) => null);
  late List<int> counters = List.generate(11, (index) => 0);

  void startTimer(int index) {
    if (!isPlaying[index]) {
      timers[index] =
          Timer.periodic(const Duration(milliseconds: 300), (timer) {
        setState(() {
          double value = sin(counters[index] / 8.75 * pi);
          counters[index]++;
          st[index]++;
          sinPoints[index].add(FlSpot(st[index], value));

          if (sinPoints[index].length > limitCount) {
            sinPoints[index].removeAt(0); // 队列超过33个值时，自动删除最旧的数据点
          }
        });
      });
      isPlaying[index] = true;
    }
  }

  void stopTimer(int index) {
    timers[index]?.cancel();
    isPlaying[index] = false;
  }

  void startAllTimer() {
    sinPoints.asMap().forEach((index, _) {
      startTimer(index);
    });
  }

  void stopAllTimer() {
    sinPoints.asMap().forEach((index, _) {
      stopTimer(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Test'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'All CH:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    startAllTimer();
                  },
                  icon: Icon(Icons.play_circle),
                  iconSize: 40,
                ),
                IconButton(
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    stopAllTimer();
                  },
                  icon: Icon(Icons.stop_circle),
                  iconSize: 40,
                ),
              ],
            ),
            ...List.generate(
              10,
              (index) {
                if(index % 2 == 1) {
                  return Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // 框線顏色
                              width: 2.0, // 框線寬度
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)), // 圓角半徑
                          ),
                          width: screenWidth * 0.42,
                          child: Column(
                            children: [
                              Text(
                                'Ch${index}',
                                style: TextStyle(
                                  color: widget.sinColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    splashRadius: 12,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      startTimer(index);
                                    },
                                    icon: Icon(Icons.play_circle),
                                    iconSize: 20,
                                  ),
                                  IconButton(
                                    splashRadius: 12,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      stopTimer(index);
                                    },
                                    icon: Icon(Icons.stop_circle),
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                              AspectRatio(
                                aspectRatio: 1.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: LineChart(
                                    LineChartData(
                                      minY: -1,
                                      maxY: 1,
                                      minX: sinPoints[index].isEmpty
                                          ? 0
                                          : sinPoints[index].first.x,
                                      maxX: sinPoints[index].isEmpty
                                          ? 10000
                                          : sinPoints[index].first.x + 34,
                                      lineTouchData:
                                      const LineTouchData(enabled: false),
                                      gridData: const FlGridData(
                                        show: false,
                                        drawVerticalLine: false,
                                      ),
                                      lineBarsData: [
                                        sinLine(sinPoints[index]),
                                      ],
                                      titlesData: titlesData,
                                      borderData: FlBorderData(
                                        show: true,
                                        border: const Border(
                                          bottom: BorderSide(
                                              color: Colors.black, width: 3),
                                          left: BorderSide(
                                              color: Colors.black, width: 1),
                                          top:
                                          BorderSide(color: Colors.transparent),
                                          right:
                                          BorderSide(color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // 框線顏色
                              width: 2.0, // 框線寬度
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(8.0)), // 圓角半徑
                          ),
                          width: screenWidth * 0.42,
                          child: Column(
                            children: [
                              Text(
                                'Ch${index + 1}',
                                style: TextStyle(
                                  color: widget.sinColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    splashRadius: 12,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      startTimer(index+1);
                                    },
                                    icon: Icon(Icons.play_circle),
                                    iconSize: 20,
                                  ),
                                  IconButton(
                                    splashRadius: 12,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      stopTimer(index+1);
                                    },
                                    icon: Icon(Icons.stop_circle),
                                    iconSize: 20,
                                  ),
                                ],
                              ),
                              AspectRatio(
                                aspectRatio: 1.5,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 24.0),
                                  child: LineChart(
                                    LineChartData(
                                      minY: -1,
                                      maxY: 1,
                                      minX: sinPoints[index+1].isEmpty
                                          ? 0
                                          : sinPoints[index+1].first.x,
                                      maxX: sinPoints[index+1].isEmpty
                                          ? 10000
                                          : sinPoints[index+1].first.x + 34,
                                      lineTouchData:
                                      const LineTouchData(enabled: false),
                                      gridData: const FlGridData(
                                        show: false,
                                        drawVerticalLine: false,
                                      ),
                                      lineBarsData: [
                                        sinLine(sinPoints[index+1]),
                                      ],
                                      titlesData: titlesData,
                                      borderData: FlBorderData(
                                        show: true,
                                        border: const Border(
                                          bottom: BorderSide(
                                              color: Colors.black, width: 3),
                                          left: BorderSide(
                                              color: Colors.black, width: 1),
                                          top:
                                          BorderSide(color: Colors.transparent),
                                          right:
                                          BorderSide(color: Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                }else{
                  return SizedBox(height: 5,);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  LineChartBarData sinLine(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      dotData: const FlDotData(
        show: false,
      ),
      barWidth: 4,
      isCurved: true,
    );
  }
}

class AppColors {
  static const Color contentColorBlue = Color(0xFF2196F3);
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

FlTitlesData get titlesData => FlTitlesData(
  bottomTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  rightTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  topTitles: AxisTitles(
    sideTitles: SideTitles(showTitles: false),
  ),
  leftTitles: AxisTitles(
    sideTitles: leftTitles()
  )
);


Widget leftTitlelessWidget(double value, TitleMeta titleMeta){
  String text = "";
  const style = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: Colors.grey
  );
  switch(value.toInt()){
    case -1:
      text = '-1';
      break;
    case 0:
      text = '0';
      break;
    case 1:
      text = '1';
      break;
    default:return Container();
  }
  return Text(text, style: style, textAlign: TextAlign.center,);
}
SideTitles leftTitles()=>SideTitles(
  getTitlesWidget: leftTitlelessWidget,
  showTitles: true,
  interval: 1,
  reservedSize: 20,
);
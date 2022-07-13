import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pie_chart/pie_chart.dart';


class Result extends StatelessWidget {

  _getData() async{
    final http.Response response = await http.post(Uri.parse("https://www.hiringmirror.com/api/quiz-report.php"));
    Map<String,dynamic> map = json.decode(response.body);
    print(map['report'].length);
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.connectionState == ConnectionState.done)
              return  PieChart(
                dataMap: {
                  "Total Attempt Question":double.parse(snapshot.data["report"]["total_ques"].toString()),
                  "Correct Answer":double.parse(snapshot.data["report"]["currect_ans"].toString()),
                  "Your Score in %":double.parse(snapshot.data["report"]["scoreinper"].toString()),
                },
                // dataMap: snapshot.data["report"],
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                colorList: [
                  Colors.red,Colors.green,Colors.blue
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "Result",
                legendOptions: LegendOptions(
                 showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  // legendShape: _BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              );
            else
              return Center(child: CircularProgressIndicator());
          }
      ),
    );
  }

  static List<charts.Series<LinearSales, int>> dataList(Map<String, dynamic> apiData) {
    List<LinearSales> list = new List();

    for(int i=0; i<apiData['report'].length; i++)
      list.add(new LinearSales(i, apiData['report'][i]));

    return [
      new charts.Series<LinearSales, int>(
        id: 'total_ques',
        domainFn: (LinearSales ques, _) => ques.total_ques,
        measureFn: (LinearSales ans, _) => ans.currect_ans,
        data: list,
        labelAccessorFn: (LinearSales row, _) => '${row.total_ques}: ${row.currect_ans}',
      )
    ];
  }
}

class LinearSales {
  final int total_ques;
  final int currect_ans;
  LinearSales(this.total_ques, this.currect_ans);
}
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesBarChart extends StatelessWidget {
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final List<double> salesData = [
    1500000,
    1735000,
    1678000,
    1890000,
    1907000,
    2300000,
    2360000,
    1980000,
    2654000,
    2789070,
    3020000,
    3245900,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Data Bar Chart'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 400,
          padding: EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Grafik Penjualan Selama 12 Bulan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 4000000,
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                            showTitles: true,
                            margin: 10,
                            reservedSize: 80,
                            getTitles: (value) {
                              return value
                                  .toString(); // Menampilkan nilai sebagai teks
                            },
                          ),
                          rightTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            rotateAngle: 45,
                            getTitles: (double value) {
                              int monthIndex = value.toInt() + 1;
                              if (monthIndex >= 1 &&
                                  monthIndex <= months.length) {
                                return months[monthIndex - 1];
                              }
                              return '';
                            },
                            margin: 10,
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: salesData
                            .asMap()
                            .entries
                            .map(
                              (entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                    y: entry.value,
                                    width: 15,
                                    colors: [Colors.blue],
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:csv/csv.dart';

class BarChartExample extends StatelessWidget {
  final List<List<dynamic>> rawData = [
    ['Bulan', 'Total Penjualan'],
    ['Januari', 1000000000],
    ['Februari', 1200000000],
    ['Maret', 1500000000],
    ['April', 2000000000],
    ['May', 1600000000],
    ['Juni', 1900000000],
    ['July', 2500000000],
    ['Agustus', 2300000000],
    ['September', 3000000000],
    ['Oktober', 1400000000],
    ['November', 3200000000],
    ['Desember', 3700000000],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Chart Example'),
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
                    "Grafik Batang",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 4000000000, // Adjust according to your data
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(showTitles: false),
                          rightTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            margin: 10,
                            getTitles: (value) {
                              salesData[value.toInt()].month,
                            },
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        barGroups: List.generate(rawData.length - 1, (index) {
                          return BarChartGroupData(
                            x: index + 1,
                            barRods: [
                              BarChartRodData(
                                y: double.parse(rawData[index + 1][1].toString()),
                                width: 15,
                                colors: [Colors.blue], // You can customize colors here
                              ),
                            ],
                            showingTooltipIndicators: [0],
                          );
                        }),
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

void main() {
  runApp(MaterialApp(
    home: BarChartExample(),
  ));
}
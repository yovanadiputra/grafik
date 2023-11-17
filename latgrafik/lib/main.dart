import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fl_chart/fl_chart.dart';
import 'package:latgrafik/barchart.dart';
import 'package:latgrafik/salesbarchart.dart';

class SalesData {
  String month;
  int totalSales;
  SalesData(this.month, this.totalSales);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Histogram',
      home: SalesHistogram(),
    );
  }
}

class SalesHistogram extends StatefulWidget {
  @override
  _SalesHistogramState createState() => _SalesHistogramState();
}

class _SalesHistogramState extends State<SalesHistogram> {
  List<SalesData> salesData = [];

  Future<void> loadSalesData() async {
    final rawData = await rootBundle.loadString('data/DataPenjualan.csv');
    final List<List<dynamic>> data =
        const CsvToListConverter(fieldDelimiter: ';', eol: '\n')
            .convert(rawData);

    // Skip the header
    data.removeAt(0);

    data.forEach((element) {
      salesData.add(SalesData(element[0], int.parse(element[1])));
    });
  }

  @override
  void initState() {
    super.initState();
    loadSalesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Histogram'),
      ),
      body: Center(
        child: FutureBuilder(
          future: loadSalesData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Penjualan per Bulan',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          barGroups: salesData.asMap().entries.map((entry) {
                            return BarChartGroupData(
                              x: entry.key
                                  .toDouble()
                                  .toInt(), // Cast to int here
                              barRods: [
                                BarChartRodData(
                                  y: entry.value.totalSales.toDouble(),
                                  width: 4.0, // Adjust bar width here
                                ),
                              ],
                            );
                          }).toList(),
                          titlesData: FlTitlesData(
                            leftTitles: SideTitles(showTitles: true),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (double value) {
                                return salesData[value.toInt()].month;
                              },
                            ),
                          ),
                          gridData: FlGridData(
                            show: true,
                            horizontalInterval: 1.0,
                            drawVerticalLine: false,
                            checkToShowHorizontalLine: (value) => true,
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                                color: const Color(0xff37434d), width: 1),
                          ),
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

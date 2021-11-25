import 'package:covid_news/model/covidModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class CountryDetail extends StatefulWidget {
  Country country;
  CountryDetail(this.country, {Key? key}) : super(key: key);
  @override
  _CountryDetailState createState() => _CountryDetailState();
}

class _CountryDetailState extends State<CountryDetail> {
  List<_PieData>? _pieData;
  @override
  Widget build(BuildContext context) {
    _pieData = [
      _PieData(
          widget.country.newConfirmed.toString() +
              " / " +
              widget.country.totalConfirmed.toString(),
          widget.country.newConfirmed,
          "New Confirmed"),
      _PieData(
          widget.country.newDeaths.toString() +
              " / " +
              widget.country.totalDeaths.toString(),
          widget.country.newDeaths,
          "New Deaths"),
      _PieData(
          widget.country.newRecovered.toString() +
              " / " +
              widget.country.totalRecovered.toString(),
          widget.country.newRecovered,
          "New Recovered"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Cov News"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SfCircularChart(
                title: ChartTitle(
                    text: widget.country.country +
                        "(" +
                        widget.country.countryCode +
                        ")",
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                legend: Legend(isVisible: true),
                series: <PieSeries<_PieData, String>>[
                  PieSeries<_PieData, String>(
                      explode: true,
                      explodeIndex: 0,
                      dataSource: _pieData,
                      xValueMapper: (_PieData data, _) => data.xData,
                      yValueMapper: (_PieData data, _) => data.yData,
                      dataLabelMapper: (_PieData data, _) => data.text,
                      dataLabelSettings: DataLabelSettings(isVisible: true)),
                ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Table(
                  // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(children: [
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]),
                    TableRow(children: [
                      const Center(
                          child: Text("New Confirmed Cases",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Center(
                        child: Text(
                          widget.country.newConfirmed.toString(),
                        ),
                      ),
                    ]),
                    // ignore: prefer_const_constructors
                    TableRow(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                    TableRow(children: [
                      const Center(
                          child: Text("Total Confirmed Cases",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Center(
                        child: Text(
                          widget.country.totalConfirmed.toString(),
                        ),
                      ),
                    ]),
                    // ignore: prefer_const_constructors
                    TableRow(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),

                    TableRow(children: [
                      const Center(
                          child: Text("Total Deaths",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Center(
                        child: Text(
                          widget.country.totalDeaths.toString(),
                        ),
                      ),
                    ]),
                    // ignore: prefer_const_constructors
                    TableRow(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                    TableRow(children: [
                      const Center(
                          child: Text("New Recovered",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))),
                      Center(
                        child: Text(
                          widget.country.newRecovered.toString(),
                        ),
                      ),
                    ]),
                    // ignore: prefer_const_constructors
                    TableRow(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}

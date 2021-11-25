import 'package:covid_news/model/covidModel.dart';
import 'package:covid_news/model/user.dart';
import 'package:covid_news/screens/country_detail.dart';
import 'package:covid_news/screens/profile.dart';
import 'package:covid_news/screens/wrapper.dart';
import 'package:covid_news/services/ath.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'model/stateModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future data;

  late Future statedata;
  late CovReport cr;
  late List<StateData> st;
  final AuthService auth = AuthService();

  @override
  void initState() {
    statedata = getStateData();
    data = getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<_PieData>? _pieData = [
      _PieData("10", 15, "Newly Affected"),
      _PieData("10", 15, "Newly Recovered"),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Cov News"),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
            icon: const CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
            future: data,
            builder: (context, snap) {
              if (snap.hasData) {
                cr = snap.data as CovReport;
                _pieData = [
                  _PieData(
                      cr.global.newConfirmed.toString() +
                          " / " +
                          cr.global.totalConfirmed.toString(),
                      cr.global.newConfirmed,
                      "New Confirmed"),
                  _PieData(
                      cr.global.newDeaths.toString() +
                          " / " +
                          cr.global.totalDeaths.toString(),
                      cr.global.newDeaths,
                      "New Deaths"),
                  _PieData(
                      cr.global.newRecovered.toString() +
                          " / " +
                          cr.global.totalRecovered.toString(),
                      cr.global.newRecovered,
                      "New Recovered"),
                ];
                return Column(
                  children: [
                    SfCircularChart(
                        title: ChartTitle(
                            text: 'Global Covid Report',
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
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                        ]),
                    const SizedBox(
                      height: 0,
                    ),
                    const Center(
                        child: Text(
                      "Statewise News",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    FutureBuilder(
                        future: statedata,
                        builder: (c, sp) {
                          if (sp.hasData) {
                            st = sp.data as List<StateData>;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: st.length,
                                    itemBuilder: (c, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          launchURL(
                                              st[i].covid19Site.toString());
                                        },
                                        child: Card(
                                          elevation: 4.0,
                                          child: Container(
                                            // color: Colors.orange,
                                            child: Center(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        width: 170,
                                                        child: Center(
                                                          child: Text(
                                                            st[i]
                                                                .notes
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 8,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        }),
                    const Center(
                        child: Text(
                      "Countries",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cr.countries.length,
                          itemBuilder: (c, i) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CountryDetail(cr.countries[i]);
                                  }));
                                },
                                title: Text(cr.countries[i].country.toString()),
                                subtitle: Text("New Confirmed : " +
                                    cr.countries[i].newConfirmed.toString()),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
      floatingActionButton: ElevatedButton.icon(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Wrapper()),
                (Route<dynamic> route) => false);
          },
          label: Text("Sign Out")),
    );
  }
}

launchURL(String url) async {
  launch(url);
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}

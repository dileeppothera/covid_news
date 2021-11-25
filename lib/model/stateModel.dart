// ignore_for_file: file_names, prefer_if_null_operators

import 'dart:convert';
import 'package:http/http.dart' as http;

Future getStateData() async {
  final response = await http.get(
    Uri.parse('https://covidtracking.com/api/states/info'),
  );
  print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    var responseJson = jsonDecode(response.body);

    // return State.fromJson(jsonDecode(response.body));
    return (responseJson as List).map((p) => StateData.fromJson(p)).toList();
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get data2.');
  }
}

class StateData {
  String? state;
  String? notes;
  String? covid19Site;
  String? covid19SiteSecondary;
  String? covid19SiteTertiary;
  String? covid19SiteQuaternary;
  String? covid19SiteQuinary;
  String? twitter;
  String? covid19SiteOld;
  String? covidTrackingProjectPreferredTotalTestUnits;
  String? covidTrackingProjectPreferredTotalTestField;
  String? totalTestResultsField;
  String? pui;
  bool? pum;
  String? name;
  String? fips;

  StateData(
      {required this.state,
      required this.notes,
      required this.covid19Site,
      required this.covid19SiteSecondary,
      required this.covid19SiteTertiary,
      required this.covid19SiteQuaternary,
      required this.covid19SiteQuinary,
      required this.twitter,
      required this.covid19SiteOld,
      required this.covidTrackingProjectPreferredTotalTestUnits,
      required this.covidTrackingProjectPreferredTotalTestField,
      required this.totalTestResultsField,
      required this.pui,
      required this.pum,
      required this.name,
      required this.fips});

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
      state: json['state'],
      notes: json['notes'],
      covid19Site: json['covid19Site'],
      covid19SiteSecondary: json['covid19SiteSecondary'],
      covid19SiteTertiary: json['covid19SiteTertiary'],
      covid19SiteQuaternary: json['covid19SiteQuaternary'],
      covid19SiteQuinary: json['covid19SiteQuinary'],
      twitter: json['twitter'],
      covid19SiteOld: json['covid19SiteOld'],
      covidTrackingProjectPreferredTotalTestUnits:
          json['covidTrackingProjectPreferredTotalTestUnits'],
      covidTrackingProjectPreferredTotalTestField:
          json['covidTrackingProjectPreferredTotalTestField'],
      totalTestResultsField: json['totalTestResultsField'],
      pui: json['pui'],
      pum: json['pum'],
      name: json['name'],
      fips: json['fips']);

  // factory CovReport.fromJson(Map<String, dynamic> json) => CovReport(
  //     id: json["ID"],
  //     message: json["Message"],
  //     global: Global.fromJson(json["Global"]),
  //     countries: List<Country>.from(
  //         json["Countries"].map((x) => Country.fromJson(x))),
  //     date: DateTime.parse(json["Date"]),
  //   );
}

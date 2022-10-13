import 'dart:convert';

import 'package:covid_app/Model/details.dart';
import 'package:covid_app/Services/app_url.dart';
import 'package:http/http.dart' as http;

class stateservices {
  Future<WorldStatesApi> getdata() async {
    final response = await http.get(Uri.parse(AppUrl.baseurl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesApi.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getcountriesdata() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countrieslist));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swim_app/models/gettime.dart';

class GetTimeApi {
  static Future<GetTime> getTimes(
      String id, String date, String day, String slot) async {
    final response = await http.get(Uri.parse(
        'https://widdev.com/swim/api/GetTimeApi.php?id=$id&date=$date&day=$day&slot=$slot'));

    if (response.statusCode == 200) {
      return getTimeFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

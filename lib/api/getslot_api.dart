import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swim_app/models/getslots.dart';
import 'package:http/http.dart' as http;

class TimeSlotApi {
  static Future<TimeSlot> getSlots(String id, String day) async {
    final response = await http.get(Uri.parse(
        'https://widdev.com/swim/api/GetSlotApi.php?id=$id&day=$day'));

    if (response.statusCode == 200) {
     
      return timeSlotFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}

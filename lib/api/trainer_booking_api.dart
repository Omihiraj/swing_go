import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swim_app/models/trainer_booking.dart';
import 'package:http/http.dart' as http;

class TrainerBookApi {
  static Future<List<TrainerBook>> getBooking(int id) async {
    final response = await http
        .get(Uri.parse('https://widdev.com/swim/api/GetBookApi.php?id=$id'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return trainerBookFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<List<TrainerBook>> getBookingLocally(
      BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/bookingdata.json');
    return trainerBookFromJson(data);
  }
}

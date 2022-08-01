import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swim_app/models/bookings.dart';
import 'package:http/http.dart' as http;

class BookingApi {
  static Future<List<Booking>> getBookings() async {
    const url = '';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);

    return body.map<Booking>(Booking.fromJson).toList();
  }

  static Future<List<Booking>> getBookingsLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/bookings.json');
    final body = json.decode(data);

    return body.map<Booking>(Booking.fromJson).toList();
  }
}

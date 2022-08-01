import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swim_app/models/pools.dart';
import 'package:http/http.dart' as http;

class PoolApi {
  static Future<List<Pool>> getPools() async {
    final response =
        await http.get(Uri.parse('https://widdev.com/swim/api/PoolApi.php'));

    if (response.statusCode == 200) {
      return poolFromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Pool>> getUsersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/pools.json');

    return poolFromJson(data);
  }
}

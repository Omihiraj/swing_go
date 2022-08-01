import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:swim_app/models/trainers.dart';
import 'package:http/http.dart' as http;

class TrainerApi {
  static Future<List<Trainer>> getTrainers() async {
    final response =
        await http.get(Uri.parse('https://widdev.com/swim/api/TrainerApi.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return trainerFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Trainer>> getTrainersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/trainers.json');
    final body = json.decode(data);

    return body.map<Trainer>(Trainer.fromJson).toList();
  }
}

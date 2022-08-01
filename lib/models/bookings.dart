import 'package:flutter/cupertino.dart';

class Booking {
  String? date;
  String? time;
  int? participents;
  String? pool;
  String? trainer;

  Booking(
      {@required this.date,
      @required this.time,
      @required this.participents,
      @required this.pool,
      @required this.trainer});

  static Booking fromJson(json) => Booking(
        date: json['date'],
        time: json['time'],
        participents: json['participents'],
        pool: json['pool'],
        trainer: json['Trainer'],
      );
}

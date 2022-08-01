// To parse this JSON data, do
//
//     final trainerBook = trainerBookFromJson(jsonString);

import 'dart:convert';

List<TrainerBook> trainerBookFromJson(String str) => List<TrainerBook>.from(
    json.decode(str).map((x) => TrainerBook.fromJson(x)));

String trainerBookToJson(List<TrainerBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrainerBook {
  TrainerBook({
    required this.bookingId,
    required this.trainerId,
    required this.traineeName,
    required this.traineeAddress,
    required this.traineeImg,
    required this.traineeMobile,
    required this.poolName,
    required this.ownPool,
    required this.lessonName,
    required this.date,
    required this.time,
    required this.status,
  });

  String bookingId;
  String trainerId;
  String traineeName;
  String traineeAddress;
  String traineeImg;
  String traineeMobile;
  String poolName;
  String ownPool;
  String lessonName;
  DateTime date;
  String time;
  String status;

  factory TrainerBook.fromJson(Map<String, dynamic> json) => TrainerBook(
        bookingId: json["booking_id"],
        trainerId: json["trainer_id"],
        traineeName: json["trainee_name"],
        traineeAddress: json["trainee_address"],
        traineeImg: json["trainee_img"],
        traineeMobile: json["trainee_mobile"],
        poolName: json["pool_name"],
        ownPool: json["own_pool"],
        lessonName: json["lesson_name"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "trainer_id": trainerId,
        "trainee_name": traineeName,
        "trainee_address": traineeAddress,
        "trainee_img": traineeImg,
        "trainee_mobile": traineeMobile,
        "pool_name": poolName,
        "own_pool": ownPool,
        "lesson_name": lessonName,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "status": status,
      };
}

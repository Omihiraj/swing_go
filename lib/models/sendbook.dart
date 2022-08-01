import 'dart:convert';

List<SendBook> sendBookFromJson(String str) =>
    List<SendBook>.from(json.decode(str).map((x) => SendBook.fromJson(x)));

String sendBookToJson(List<SendBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SendBook {
  SendBook({
    required this.trainerId,
    required this.traineeId,
    required this.poolId,
    required this.ownPool,
    required this.lessonId,
    required this.date,
    required this.timeSlot,
    required this.time,
  });

  int trainerId;
  int traineeId;
  int poolId;
  bool ownPool;
  int lessonId;
  DateTime date;
  String timeSlot;
  String time;

  factory SendBook.fromJson(Map<String, dynamic> json) => SendBook(
        trainerId: json["trainer_id"],
        traineeId: json["trainee_id"],
        poolId: json["pool_id"],
        ownPool: json["own_pool"],
        lessonId: json["lesson_id"],
        date: DateTime.parse(json["date"]),
        timeSlot: json["time_slot"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "trainer_id": trainerId,
        "trainee_id": traineeId,
        "pool_id": poolId,
        "own_pool": ownPool,
        "lesson_id": lessonId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time_slot": timeSlot,
        "time": time,
      };
}

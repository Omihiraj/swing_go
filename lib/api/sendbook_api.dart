import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendBookApi {
  static Future sendBook(
      {required String trainerId,
      required String traineeId,
      required int poolId,
      required bool ownPool,
      required int lessonId,
      required DateTime date,
      required String timSlot,
      required String time}) async {
    final response = await http.post(
      Uri.parse('https://widdev.com/swim/api/SendBookApi.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "trainer_id": trainerId,
        "trainee_id": traineeId,
        "pool_id": poolId,
        "own_pool": ownPool,
        "lesson_id": lessonId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time_slot": timSlot,
        "time": time
      }),
    );
  }
}

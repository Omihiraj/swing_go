import 'dart:convert';

TimeSlot timeSlotFromJson(String str) => TimeSlot.fromJson(json.decode(str));

String timeSlotToJson(TimeSlot data) => json.encode(data.toJson());

class TimeSlot {
  TimeSlot({
    required this.timeslots,
  });

  List<String> timeslots;

  factory TimeSlot.fromJson(Map<String, dynamic> json) => TimeSlot(
        timeslots: List<String>.from(json["timeslots"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "timeslots": List<dynamic>.from(timeslots.map((x) => x)),
      };
}

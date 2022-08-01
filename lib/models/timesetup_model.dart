import 'dart:convert';

List<TimeSetup> timeSetupFromJson(String str) =>
    List<TimeSetup>.from(json.decode(str).map((x) => TimeSetup.fromJson(x)));

String timeSetupToJson(List<TimeSetup> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeSetup {
  TimeSetup({
    required this.day,
    required this.slots,
    required this.duration,
  });

  String day;
  List<String> slots;
  int duration;

  factory TimeSetup.fromJson(Map<String, dynamic> json) => TimeSetup(
        day: json["day"],
        slots: List<String>.from(json["slots"].map((x) => x)),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "slots": List<dynamic>.from(slots.map((x) => x)),
        "duration": duration,
      };
}

import 'dart:convert';

GetTime getTimeFromJson(String str) => GetTime.fromJson(json.decode(str));

String getTimeToJson(GetTime data) => json.encode(data.toJson());

class GetTime {
  GetTime({
    required this.items,
  });

  List<String> items;

  factory GetTime.fromJson(Map<String, dynamic> json) => GetTime(
        items: List<String>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}

import 'dart:convert';

List<Trainer> trainerFromJson(String str) =>
    List<Trainer>.from(json.decode(str).map((x) => Trainer.fromJson(x)));

String trainerToJson(List<Trainer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trainer {
  Trainer({
    required this.id,
    required this.username,
    required this.email,
    required this.address,
    required this.availability,
    required this.students,
    required this.phonenumber,
    required this.price,
    required this.urlAvatar,
  });
  String id;
  String username;
  String email;
  String address;
  bool availability;
  int students;
  String phonenumber;
  String price;
  String urlAvatar;

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        availability: json["availability"],
        students: json["students"],
        phonenumber: json["phonenumber"],
        price: json["price"],
        urlAvatar: json["urlAvatar"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "address": address,
        "availability": availability,
        "students": students,
        "phonenumber": phonenumber,
        "price": price,
        "urlAvatar": urlAvatar,
      };
}

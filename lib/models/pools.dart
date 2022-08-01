import 'dart:convert';

List<Pool> poolFromJson(String str) =>
    List<Pool>.from(json.decode(str).map((x) => Pool.fromJson(x)));

String poolToJson(List<Pool> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pool {
  Pool({
    required this.poolname,
    required this.pooladdress,
    required this.pooldetails,
    required this.mainimage,
    required this.gallary,
  });

  String poolname;
  String pooladdress;
  String pooldetails;
  String mainimage;
  List<String> gallary;

  factory Pool.fromJson(Map<String, dynamic> json) => Pool(
        poolname: json["poolname"],
        pooladdress: json["pooladdress"],
        pooldetails: json["pooldetails"],
        mainimage: json["mainimage"],
        gallary: List<String>.from(json["gallary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "poolname": poolname,
        "pooladdress": pooladdress,
        "pooldetails": pooldetails,
        "mainimage": mainimage,
        "gallary": List<dynamic>.from(gallary.map((x) => x)),
      };
}

// To parse this JSON data, do
//
//     final routeModel = routeModelFromJson(jsonString);

import 'dart:convert';

List<RouteModel> routeModelFromJson(String str) =>
    List<RouteModel>.from(json.decode(str).map((x) => RouteModel.fromJson(x)));

String routeModelToJson(List<RouteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RouteModel {
  RouteModel({
    required this.startingPoint,
    required this.finalPoint,
    required this.checkpoints,
  });

  String startingPoint;
  String finalPoint;
  String checkpoints;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        startingPoint: json["starting_point"],
        finalPoint: json["final_point"],
        checkpoints: json["checkpoints"],
      );

  Map<String, dynamic> toJson() => {
        "starting_point": startingPoint,
        "final_point": finalPoint,
        "checkpoints": checkpoints,
      };
}

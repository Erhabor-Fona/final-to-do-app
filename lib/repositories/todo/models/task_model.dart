// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';



class TaskModel {
    TaskModel({
        required this.id,
        required this.developerId,
        required this.description,
        required this.createdAt,
        required this.isCompleted,
        required this.title,
        required this.updatedAt,
    });

    String id;
    String developerId;
    String description;
    DateTime createdAt;
    bool isCompleted;
    String title;
    DateTime updatedAt;

    factory TaskModel.fromRawJson(String str) => TaskModel.fromJson(json.decode(str));

    // String toRawJson() => json.encode(toJson());

    factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        developerId: json["developer_id"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        isCompleted: json["isCompleted"],
        title: json["title"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

     factory TaskModel.createEmpty(title, description)=> TaskModel(
        id: '',
        developerId: '',
        description: description,
        createdAt: DateTime.now(),
        isCompleted: false,
        title: title,
        updatedAt: DateTime.now(),
    );

    // Map<String, dynamic> toJson() => {
    //     "id": id,
    //     "developer_id": developerId,
    //     "description": description,
    //     "created_at": createdAt.toIso8601String(),
    //     "isCompleted": isCompleted,
    //     "title": title,
    //     "updated_at": updatedAt.toIso8601String(),
    // };
}

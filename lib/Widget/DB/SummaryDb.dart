// To parse this JSON data, do
//
//     final summaryDb = summaryDbFromJson(jsonString);

import 'dart:convert';

SummaryDb summaryDbFromJson(String str) => SummaryDb.fromJson(json.decode(str));

String summaryDbToJson(SummaryDb data) => json.encode(data.toJson());

class SummaryDb {
    SummaryDb({
        this.status,
        this.message,
        this.result,
    });

    String? status;
    String? message;
    Result? result;

    factory SummaryDb.fromJson(Map<String, dynamic> json) => SummaryDb(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "result": result == null ? null : result!.toJson(),
    };
}

class Result {
    Result({
        this.view1,
    });

    List<Map<String, double>>? view1;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        view1: json["view1"] == null ? null : List<Map<String, double>>.from(json["view1"].map((x) => Map.from(x).map((k, v) => MapEntry<String, double>(k, v == null ? null : v.toDouble())))),
    );

    Map<String, dynamic> toJson() => {
        "view1": view1 == null ? null : List<dynamic>.from(view1!.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
    };
}
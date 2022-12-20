// To parse this JSON data, do
//
//     final logDb = logDbFromJson(jsonString);

import 'dart:convert';

LogDb logDbFromJson(String str) => LogDb.fromJson(json.decode(str));

String logDbToJson(LogDb data) => json.encode(data.toJson());

class LogDb {
    LogDb({
        this.status,
        this.message,
        this.result,
    });

    String? status;
    String? message;
    Result? result;

    factory LogDb.fromJson(Map<String, dynamic> json) => LogDb(
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
        this.user,
        this.farm,
        this.defaultSpecies,
        this.defaultShip,
        this.defaultUnit,
    });

    User? user;
    List<Farm>? farm;
    List<DefaultSpecy>? defaultSpecies;
    List<Default>? defaultShip;
    List<Default>? defaultUnit;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        farm: json["farm"] == null ? null : List<Farm>.from(json["farm"].map((x) => Farm.fromJson(x))),
        defaultSpecies: json["default_species"] == null ? null : List<DefaultSpecy>.from(json["default_species"].map((x) => DefaultSpecy.fromJson(x))),
        defaultShip: json["default_ship"] == null ? null : List<Default>.from(json["default_ship"].map((x) => Default.fromJson(x))),
        defaultUnit: json["default_unit"] == null ? null : List<Default>.from(json["default_unit"].map((x) => Default.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "farm": farm == null ? null : List<dynamic>.from(farm!.map((x) => x.toJson())),
        "default_species": defaultSpecies == null ? null : List<dynamic>.from(defaultSpecies!.map((x) => x.toJson())),
        "default_ship": defaultShip == null ? null : List<dynamic>.from(defaultShip!.map((x) => x.toJson())),
        "default_unit": defaultUnit == null ? null : List<dynamic>.from(defaultUnit!.map((x) => x.toJson())),
    };
}

class Default {
    Default({
        this.code,
        this.name,
    });

    String? code;
    String? name;

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "name": name == null ? null : name,
    };
}

class DefaultSpecy {
    DefaultSpecy({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory DefaultSpecy.fromJson(Map<String, dynamic> json) => DefaultSpecy(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}

class Farm {
    Farm({
        this.id,
        this.name,
        this.crop,
        this.cmiid,
        this.house,
        this.defaultFormula,
        this.defaultPlanning,
        this.summaryView1,
        this.summaryView2,
        this.houseView1,
        this.houseView2,
    });

    int? id;
    String? name;
    List<DefaultSpecy>? crop;
    List<String>? cmiid;
    List<House>? house;
    List<Default>? defaultFormula;
    List<Default>? defaultPlanning;
    List<DefaultSpecy>? summaryView1;
    List<DefaultSpecy>? summaryView2;
    List<DefaultSpecy>? houseView1;
    List<DefaultSpecy>? houseView2;

    factory Farm.fromJson(Map<String, dynamic> json) => Farm(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        crop: json["crop"] == null ? null : List<DefaultSpecy>.from(json["crop"].map((x) => DefaultSpecy.fromJson(x))),
        cmiid: json["cmiid"] == null ? null : List<String>.from(json["cmiid"].map((x) => x)),
        house: json["house"] == null ? null : List<House>.from(json["house"].map((x) => House.fromJson(x))),
        defaultFormula: json["default_formula"] == null ? null : List<Default>.from(json["default_formula"].map((x) => Default.fromJson(x))),
        defaultPlanning: json["default_planning"] == null ? null : List<Default>.from(json["default_planning"].map((x) => Default.fromJson(x))),
        summaryView1: json["summary_view1"] == null ? null : List<DefaultSpecy>.from(json["summary_view1"].map((x) => DefaultSpecy.fromJson(x))),
        summaryView2: json["summary_view2"] == null ? null : List<DefaultSpecy>.from(json["summary_view2"].map((x) => DefaultSpecy.fromJson(x))),
        houseView1: json["house_view1"] == null ? null : List<DefaultSpecy>.from(json["house_view1"].map((x) => DefaultSpecy.fromJson(x))),
        houseView2: json["house_view2"] == null ? null : List<DefaultSpecy>.from(json["house_view2"].map((x) => DefaultSpecy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "crop": crop == null ? null : List<dynamic>.from(crop!.map((x) => x.toJson())),
        "cmiid": cmiid == null ? null : List<dynamic>.from(cmiid!.map((x) => x)),
        "house": house == null ? null : List<dynamic>.from(house!.map((x) => x.toJson())),
        "default_formula": defaultFormula == null ? null : List<dynamic>.from(defaultFormula!.map((x) => x.toJson())),
        "default_planning": defaultPlanning == null ? null : List<dynamic>.from(defaultPlanning!.map((x) => x.toJson())),
        "summary_view1": summaryView1 == null ? null : List<dynamic>.from(summaryView1!.map((x) => x.toJson())),
        "summary_view2": summaryView2 == null ? null : List<dynamic>.from(summaryView2!.map((x) => x.toJson())),
        "house_view1": houseView1 == null ? null : List<dynamic>.from(houseView1!.map((x) => x.toJson())),
        "house_view2": houseView2 == null ? null : List<dynamic>.from(houseView2!.map((x) => x.toJson())),
    };
}

class House {
    House({
        this.id,
        this.name,
        this.feed,
    });

    int? id;
    String? name;
    dynamic? feed;

    factory House.fromJson(Map<String, dynamic> json) => House(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        feed: json["feed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "feed": feed,
    };
}

class User {
    User({
        this.id,
        this.username,
        this.email,
        this.permission,
    });

    int? id;
    String? username;
    String? email;
    DefaultSpecy? permission;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        permission: json["permission"] == null ? null : DefaultSpecy.fromJson(json["permission"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "permission": permission == null ? null : permission!.toJson(),
    };
}

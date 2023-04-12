// To parse this JSON data, do
//
//     final character = characterFromMap(jsonString);

import 'dart:convert';

class Character {
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  final int id;
  final String name;
  final Status status;
  final Species species;
  final String type;
  final Gender gender;
  final Location origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  factory Character.fromJson(String str) => Character.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Character.fromMap(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]] ?? Species.human,
        type: json["type"],
        gender: genderValues.map[json["gender"]] ?? Gender.unknown,
        origin: Location.fromMap(json["origin"]),
        location: Location.fromMap(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toMap(),
        "location": location.toMap(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
      };
}

enum Gender { male, female, unknown }

final genderValues = EnumValues(
    {"Female": Gender.female, "Male": Gender.male, "unknown": Gender.unknown});

class Location {
  Location({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

enum Species { human, alien }

final speciesValues =
    EnumValues({"Alien": Species.alien, "Human": Species.human});

enum Status { alive, unknown, dead }

final statusValues = EnumValues(
    {"Alive": Status.alive, "Dead": Status.dead, "unknown": Status.unknown});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

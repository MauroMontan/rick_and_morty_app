import 'package:flutter/material.dart';
import 'package:dio/dio.dart' show Dio;
import 'package:rick_and_morty_app/models/character.dart';

class CharacterProvider extends ChangeNotifier {
  static const _url = "https://rickandmortyapi.com/api/character";
  final dio = Dio();

  CharacterProvider() {
    loadCharacters();
  }

  String? next;

  List<Character> characters = [];

  Future<void> searchByName(String name) async {
    List<Character> result = [];

    try {
      final response = await dio
          .get("https://rickandmortyapi.com/api/character/?name=$name");
      final objRes = response.data;

      final tempRawCharacters = objRes["results"] as List<dynamic>;

      for (var character in tempRawCharacters) {
        final parsedData = Character.fromMap(character);

        result.add(parsedData);
      }

      characters.clear();
      characters.addAll(result);
      if (name == "") {
        characters.clear();
        loadCharacters();
      }
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  Future<void> loadMore() async {
    if (next != null) {
      final response = await dio.get(next!);
      final objRes = response.data;

      next = objRes["info"]["next"];

      final tempRawCharacters = objRes["results"] as List<dynamic>;

      for (var character in tempRawCharacters) {
        final parsedData = Character.fromMap(character);

        characters.add(parsedData);
      }
      notifyListeners();
    }
  }

  Future<void> loadCharacters() async {
    final response = await dio.get(_url);

    final objRes = response.data;

    next = objRes["info"]["next"];

    final characterList = List<Character>.generate(
        20, (i) => Character.fromMap(objRes["results"][i]));

    characters.clear();

    for (var element in characterList) {
      characters.add(element);
    }

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import "package:dio/dio.dart";
import 'package:rick_and_morty_app/models/episode.dart';

class EpisodeProvider extends ChangeNotifier {
  final dio = Dio();

  Future<Episode>? currentEpisode(String url) async {
    final response = await dio.get(url);

    final episode = Episode.fromMap(response.data);

    return episode;
  }
}

import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:rick_and_morty_app/providers/episodes_provider.dart';

import '../models/episode.dart';

class EpisodeList extends StatelessWidget {
  final List<String> episodes;
  const EpisodeList({super.key, required this.episodes});

  @override
  Widget build(BuildContext context) {
    final episodeProvider = Provider.of<EpisodeProvider>(context);
    return ListView.builder(
        itemCount: episodes.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          final Future<Episode>? currentEpisode =
              episodeProvider.currentEpisode(episodes[index]);
          return FutureBuilder<Episode>(
            future: currentEpisode,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return EpisodeTile(
                  episode: snapshot.data!,
                  index: index,
                );
              } else {
                return Container();
              }
            },
          );
        }));
  }
}

class EpisodeTile extends StatelessWidget {
  final int index;
  const EpisodeTile({super.key, required this.episode, required this.index});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: const Icon(Icons.movie),
      dense: true,
      title: Text(episode.name),
      subtitle: Text(episode.airDate),
      trailing: Text(episode.episode),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/widgets/widgets.dart';

import '../models/character.dart';

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CharacterAbout(),
            ),
            Title(
                color: Colors.black,
                child: const Text("Episodes where appears")),
            EpisodeList(episodes: character.episode)
          ],
        ),
      ),
    );
  }
}

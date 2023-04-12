import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';
import 'package:rick_and_morty_app/widgets/character_avatar.dart';

class CharacterListRow extends StatelessWidget {
  final int index;
  final Character character;
  const CharacterListRow(
      {super.key, required this.index, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          right: 5,
        ),
        title: Text(character.name),
        subtitle: Text(character.origin.name),

        leading: AvatarImage(
          index: index,
          image: character.image,
          status: character.status,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        //    tileColor: const Color(0xffa3c4bc),
        onTap: () => Navigator.pushNamed(context, "characterDetail",
            arguments: character),
      ),
    );
  }
}

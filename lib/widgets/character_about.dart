import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character.dart';

class CharacterAbout extends StatelessWidget {
  const CharacterAbout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Character character =
        ModalRoute.of(context)!.settings.arguments as Character;

    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: 140,
                  height: 140,
                  child: Hero(
                    tag: "imageId - ${character.id}",
                    child: Image(
                      fit: BoxFit.contain,
                      image: NetworkImage(character.image),
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        ),
                        Text(
                          character.origin.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 3,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(10),
          child: InfoTable(character: character),
        )
      ],
    );
  }
}

class InfoTable extends StatelessWidget {
  const InfoTable({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return DataTable(
        showBottomBorder: true,
        border: TableBorder.symmetric(),
        columns: const [
          DataColumn(label: Text("Species")),
          DataColumn(label: Text("Status")),
          DataColumn(label: Text("Location")),
          DataColumn(label: Text("Gender")),
          DataColumn(label: Text("Type")),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text(character.species.name)),
            DataCell(Text(character.status.name)),
            DataCell(Text(character.location.name)),
            DataCell(Text(character.gender.name)),
            DataCell(Text(character.type)),
          ]),
        ]);
  }
}

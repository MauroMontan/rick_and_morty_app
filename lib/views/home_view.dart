import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/providers/characters_provider.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/widgets/character_listtile.dart';

import '../models/character.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController controller = ScrollController();
  bool isSearching = false;
  bool isLoadingContent = true;
  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (!isSearching) {
        if (controller.position.pixels == controller.position.maxScrollExtent) {
          isLoadingContent = true;
          loadMoreCharacters();
        }
      }
    });
  }

  void loadMoreCharacters() {
    Future.delayed(Duration.zero, () {
      final characterProvider =
          Provider.of<CharacterProvider>(context, listen: false);
      characterProvider.loadMore();
    });

    setState(() {});
  }

  toggleSearch() {}

  @override
  Widget build(BuildContext context) {
    final characterProvider = Provider.of<CharacterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? SizedBox(
                height: 45,
                child: TextField(
                    decoration: searchStyle(),
                    onChanged: (String value) async {
                      if (value == "") {
                        isSearching = false;
                      }
                      isLoadingContent = false;
                      await characterProvider.searchByName(value);
                    }),
              )
            : const Text("Characters"),
        centerTitle: true,
        actions: [
          IconButton(
              iconSize: 27,
              onPressed: () {
                isSearching = !isSearching;
                if (!isSearching) {
                  characterProvider.loadCharacters();
                }

                setState(() {});
              },
              icon: Icon(isSearching ? Icons.clear : Icons.search)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => characterProvider.loadCharacters(),
        child: ListView.builder(
            controller: controller,
            itemCount: characterProvider.characters.length,
            itemBuilder: (context, index) {
              final Character character = characterProvider.characters[index];

              if (index == characterProvider.characters.length - 1) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoadingContent
                        ? const CircularProgressIndicator()
                        : const Text("thats all!"),
                  ),
                );
              }

              return CharacterListRow(
                  index: character.id, character: character);
            }),
      ),
    );
  }

  InputDecoration searchStyle() {
    return InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: const EdgeInsets.all(10),
        isDense: true,
        focusColor: Colors.indigo,
        labelStyle: const TextStyle(color: Colors.grey),
        hintText: "Morty Smith");
  }
}

import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/providers/characters_provider.dart';
import 'package:rick_and_morty_app/providers/episodes_provider.dart';
import 'package:rick_and_morty_app/views/character_view.dart';
import 'package:rick_and_morty_app/views/home_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        ChangeNotifierProvider(create: (context) => EpisodeProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      title: 'Material App',
      initialRoute: "home",
      routes: {
        "home": (_) => const HomeView(),
        "characterDetail": (_) => const CharacterDetail()
      },
    );
  }
}

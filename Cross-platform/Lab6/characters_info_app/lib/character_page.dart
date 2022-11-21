import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'character_model.dart';

class CharacterPage extends StatefulWidget {
  final int characterId;
  const CharacterPage({Key? key, required this.characterId}) : super(key: key);

  @override
  State<CharacterPage> createState() => _CharacterPageState(characterId: characterId);
}

class _CharacterPageState extends State<CharacterPage> {
  final int characterId;
   _CharacterPageState({required this.characterId});

  Future<CharacterModel> getCharacterData() async {
    final response = await http.get(Uri.parse(
        "https://www.breakingbadapi.com/api/characters/$characterId"));
    if (response.statusCode == 200) {
      return CharacterModel.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception("Ошибка при получении персонажа");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Данные персонажа"),
      ),
      body: FutureBuilder(
        future: getCharacterData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}",
                style: const TextStyle(color: Colors.red));
          } else if (snapshot.hasData) {
            CharacterModel character = snapshot.data!;
            return Column(
              children: [
                Image(image: NetworkImage(character.img!)),
                Text(character.name!)
              ],
            );
          } else {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

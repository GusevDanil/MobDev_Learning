import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'character_model.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  Future<List<CharacterModel>> getCharacters() async {
    final response = await http
        .get(Uri.parse("https://www.breakingbadapi.com/api/characters/"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<CharacterModel> characters = [];
      for (var character in jsonResponse) {
        characters.add(CharacterModel.fromJson(character));
      }
      return characters;
    } else {
      throw Exception("Ошибка при получении персонажей");
    }
  }

  @override
  Widget build(BuildContext context) {
    getCharacters();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Персонажи"),
      ),
      body: FutureBuilder(
        future: getCharacters(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}",
                style: const TextStyle(color: Colors.red));
          } else if (snapshot.hasData) {
            List<CharacterModel> charactersList = snapshot.data!;
            return ListView.builder(
                itemCount: charactersList.length,
                itemBuilder: (context, index) {
                  CharacterModel character = charactersList[index];
                  return CharacterTile(
                    imgUrl: character.img!,
                    nickName: character.name!,
                  );
                });
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

class CharacterTile extends StatelessWidget {
  final String imgUrl;
  final String nickName;

  const CharacterTile({Key? key, required this.imgUrl, required this.nickName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: NetworkImage(imgUrl),
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      ),
      title: Text(nickName),
      onTap: () {
        if (nickName.contains("Saul")) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Image(
                image: NetworkImage(
                    "https://media.moddb.com/images/mods/1/56/55177/bandicam_2022-09-05_20-00-55-025.jpg"),
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              duration: Duration(seconds: 3)));
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:xaldigital_app/Model/Nationality.dart';
import 'package:xaldigital_app/Model/Search_history.dart';
import 'package:xaldigital_app/Services/CallApi.dart';
import 'package:xaldigital_app/Services/Database.dart';
import 'package:xaldigital_app/UI/Widgets/Card.dart';

class SearchButton extends SearchDelegate {


  //Lista en caso de que tambien se quiera mostrar el historial al momento de buscar
  List<String> searchResults = [""];

  @override
  Widget? buildLeading(BuildContext context) {
    //###
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.clear));
  }

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<Natyonality>(
        future: queryname(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            guardarDatos();

            return Scaffold(
                body: Column(
              children: [
                Text(
                  snapshot.data!.name,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * .5,
                    child: ListView.builder(
                      itemCount: snapshot.data!.country.length,
                      itemBuilder: (context, index) {
                        return CardInfo(
                          country: snapshot.data!.country[index]["country_id"],
                          probabilty: snapshot
                              .data!.country[index]["probability"]
                              .toString(),
                        );
                      },
                    ))
              ],
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const Center(child:  CircularProgressIndicator());
        },
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toString();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  
  guardarDatos() async {
    await DatabaseHelper.instance.add(
      HistoySearch(name: query.toString()),
    );
  }
}

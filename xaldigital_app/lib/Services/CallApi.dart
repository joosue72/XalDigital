import 'dart:async';
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:xaldigital_app/Model/Nationality.dart';


//realizamos una consulta pasando como parametro el nombre
Future<Natyonality> queryname(String name) async {
  final response = await http.get(
    Uri.parse('https://api.nationalize.io?name='+ name),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
   
  );

  if (response.statusCode == 200) {
   
    return Natyonality.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(Error);
  }
}
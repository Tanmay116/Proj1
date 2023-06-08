import 'dart:convert';

import 'package:proj1/models/Categories.dart';
import 'package:http/http.dart' as http;

// Fetch our Categories from API
Future<List<dynamic>?> fetchCategories() async {
  // const String apiUrl =
  //     "https://5f210aa9daa42f001666535e.mockapi.io/api/categories";
  var apiUrl =
      Uri.parse('https://5f210aa9daa42f001666535e.mockapi.io/api/categories');

  final response = await http.get(apiUrl);
  
  // print(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print('hello');
    // int a = 1;
    // print((json.decode(response.body) as List).toList().runtimeType);


    List<dynamic> categories = (json.decode(response.body) as List).map((data) => Category.formJson(data)).toList();
// It returns list of categories
    // print(categories.runtimeType);
    // print(categories);
    return categories;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}

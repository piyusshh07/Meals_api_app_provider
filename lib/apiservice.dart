import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meals_api_app_/Model/Meals_model.dart';
// Adjust the path if needed

class ApiService {
  Future<List<Meals>> getMeals() async {
    String baseUrl = 'https://dummyjson.com/recipes';
    Uri url = Uri.parse(baseUrl);
    var response = await http.get(url);

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode the JSON data as a Map
        Map<String, dynamic> data = jsonDecode(response.body);
        
        // Access the 'recipes' field, which is a list
        List<dynamic> recipesList = data['recipes'];

        // Map the list to Recipe objects and return it
        return recipesList.map((item) => Meals.fromJson(item)).toList();
      } else {
        throw Exception('Error fetching meals');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

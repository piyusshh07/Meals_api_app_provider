import 'package:meals_api_app/Meals_model.dart'; // Adjust path if needed
import 'package:meals_api_app/service_api.dart'; // Adjust path if needed
import 'package:riverpod/riverpod.dart';

// ApiProvider to provide an instance of ApiService
final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// FutureProvider to fetch the list of meals asynchronously
final mealsListProvider = FutureProvider<List<Recipe>>((ref) async {
  // Retrieve the ApiService instance from the apiProvider
  final apiService = ref.read(apiProvider);

  // Fetch the meals asynchronously and return the Future<List<Recipe>>
  return await apiService.getMeals();
});
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meals_api_app_/Model/Meals_model.dart';
import 'package:meals_api_app_/apiservice.dart';

class MealsProvider extends ChangeNotifier {
  MealsProvider({required this.apiService});
  final ApiService apiService;
  
  List<Meals> _meals = [];
  bool _isLoading = false;
  final List<Meals> _favoritemeals = [];

  List<Meals> get meals => _meals;
  bool get isLoading => _isLoading;
  List<Meals> get favoritemeals => _favoritemeals;

  void getMealsfromapi() async {
    _isLoading = true;
    notifyListeners();
    
    try {
      _meals = await apiService.getMeals();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToFavorite(Meals meal) {
    if (!_favoritemeals.contains(meal)) {
      _favoritemeals.add(meal);
      notifyListeners();
    }
  }

  void removeFromFavorite(Meals meal) {
    _favoritemeals.remove(meal);
    notifyListeners();
  }

  bool isFavorite(Meals meal) {
    return _favoritemeals.contains(meal);
  }
}

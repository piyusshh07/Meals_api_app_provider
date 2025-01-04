import 'dart:convert';

// Function to convert JSON string to MealsModel object
MealsModel mealsmodelFromJson(String str) => MealsModel.fromJson(json.decode(str));

// Function to convert MealsModel object to JSON string
String mealsmodelToJson(MealsModel data) => json.encode(data.toJson());

class MealsModel {
  List<Meals> recipes;
  int total;
  int skip;
  int limit;

  MealsModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  // Factory constructor to create MealsModel from JSON
  factory MealsModel.fromJson(Map<String, dynamic> json) => MealsModel(
        recipes: List<Meals>.from(json["recipes"].map((x) => Meals.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  // Convert MealsModel to JSON
  Map<String, dynamic> toJson() => {
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Meals {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  Difficulty difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> tags;
  int userId;
  String image;
  double rating;
  int reviewCount;
  List<String> mealType;

  Meals({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  // Factory constructor to create Meals from JSON
  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        prepTimeMinutes: json["prepTimeMinutes"],
        cookTimeMinutes: json["cookTimeMinutes"],
        servings: json["servings"],
        difficulty: difficultyValues.map[json["difficulty"]]!,
        cuisine: json["cuisine"],
        caloriesPerServing: json["caloriesPerServing"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        userId: json["userId"],
        image: json["image"],
        rating: json["rating"]?.toDouble() ?? 0.0, // Handle potential null
        reviewCount: json["reviewCount"] ?? 0, // Handle potential null
        mealType: List<String>.from(json["mealType"].map((x) => x)),
      );

  // Convert Meals to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "prepTimeMinutes": prepTimeMinutes,
        "cookTimeMinutes": cookTimeMinutes,
        "servings": servings,
        "difficulty": difficultyValues.reverse[difficulty],
        "cuisine": cuisine,
        "caloriesPerServing": caloriesPerServing,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "userId": userId,
        "image": image,
        "rating": rating,
        "reviewCount": reviewCount,
        "mealType": List<dynamic>.from(mealType.map((x) => x)),
      };
}

// Enum for difficulty levels
enum Difficulty { EASY, MEDIUM }

// Mapping for difficulty levels
final difficultyValues = EnumValues({
  "Easy": Difficulty.EASY,
  "Medium": Difficulty.MEDIUM,
});

// Utility class to reverse map values
class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

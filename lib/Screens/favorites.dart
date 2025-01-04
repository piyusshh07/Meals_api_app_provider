import 'package:flutter/material.dart';
import 'package:meals_api_app_/Provider/MealsProvider.dart';
import 'package:meals_api_app_/Screens/MealInfo.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: Center(
        child: mealsProvider.favoritemeals.isEmpty
            ? const Text(
                "No favorite meals added yet.",
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            : ListView.builder(
                itemCount: mealsProvider.favoritemeals.length,
                itemBuilder: (context, index) {
                  final meal = mealsProvider.favoritemeals[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> MealsInfoPage(meal: meal)));},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Stack(children: [
                              SizedBox(
                                height: 200,
                                width: double.maxFinite,
                                child: Image.network(
                                  mealsProvider.favoritemeals[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 10,
                                child: IconButton(
                                    onPressed: () {
                                      mealsProvider.removeFromFavorite(
                                          mealsProvider.favoritemeals[index]);
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Removed From Favorites",),));
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    )),
                              )
                            ]),
                            Text(
                              meal.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  meal.rating.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                const Icon(Icons.star, color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

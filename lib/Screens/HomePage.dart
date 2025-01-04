import 'package:flutter/material.dart';
import 'package:meals_api_app_/Provider/MealsProvider.dart';
import 'package:meals_api_app_/Screens/Gradient_nav_bar.dart';
import 'package:meals_api_app_/Screens/MealInfo.dart';
import 'package:meals_api_app_/Screens/SearchScreen.dart';
import 'package:meals_api_app_/Screens/favorites.dart';
import 'package:provider/provider.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Access the provider and call getMealsfromapi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MealsProvider>(context, listen: false).getMealsfromapi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mealsProvider = Provider.of<MealsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Meals Api App',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: (){
            showSearch(context: context, delegate: SearchScreen());
          }, icon: const Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FavoritesPage()));
            },
            icon: const Icon(Icons.favorite),
          )
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),

      body: Consumer<MealsProvider>(
        builder: (ctxt, value, child) {
          return Center(
            child: Container(
              child: mealsProvider.isLoading
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: mealsProvider.meals.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MealsInfoPage(
                                      meal: mealsProvider.meals[index]),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        width: double.maxFinite,
                                        child: Image.network(
                                          mealsProvider.meals[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        right: 10,
                                        child: IconButton(
                                          onPressed: () {
                                            mealsProvider.isFavorite(
                                                    mealsProvider
                                                        .meals[index])
                                                ? mealsProvider
                                                    .removeFromFavorite(
                                                        mealsProvider
                                                            .meals[index])
                                                : mealsProvider.addToFavorite(
                                                    mealsProvider
                                                        .meals[index]);
                                            ScaffoldMessenger.of(ctxt)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                mealsProvider.meals.contains(
                                                        mealsProvider
                                                            .meals[index])
                                                    ? 'Added To Favourites'
                                                    : "Removed From Favorites",
                                              ),
                                            ));
                                          },
                                          icon: Icon(
                                            mealsProvider.isFavorite(
                                                    mealsProvider.meals[index])
                                                ? Icons.favorite
                                                : Icons.favorite_outline,
                                            color: mealsProvider.isFavorite(
                                                    mealsProvider.meals[index])
                                                ? Colors.red
                                                : Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    mealsProvider.meals[index].name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        mealsProvider.meals[index].rating
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mealsProvider.getMealsfromapi(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

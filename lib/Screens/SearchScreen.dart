import 'package:flutter/material.dart';
import 'package:meals_api_app_/Model/Meals_model.dart';
import 'package:meals_api_app_/Provider/MealsProvider.dart';
import 'package:meals_api_app_/Screens/MealInfo.dart';
import 'package:provider/provider.dart';

class SearchScreen extends SearchDelegate{
 @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black, // Set background color for the search bar
        elevation: 0,
      ),
      hintColor: Colors.grey, // Hint text color
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18), // Search text color
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey), // Hint color inside the search field
      ),
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
 return [IconButton(onPressed: (){
  query='';
 }, icon: const Icon(Icons.clear,color: Colors.white,))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   IconButton(onPressed: () {
   close(context, null);
   },
   icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),);
   return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
      List<Meals> mealslist = Provider.of<MealsProvider>(context).meals;
      List<Meals> matchQuery=[];
      for(var meal in mealslist){
        if(meal.name.toLowerCase().contains(query.toLowerCase())){
             matchQuery.add(meal);
        }
      }
   return Container(
    color: Colors.black,
    child: 
    ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
      return GestureDetector(
        onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MealsInfoPage(meal: matchQuery[index])));
        },
        child: ListTile(
           leading: ClipRRect(borderRadius: BorderRadius.circular(90), child: Image.network(matchQuery[index].image)) ?? const Icon(Icons.image),
          title: Text(matchQuery[index].name,style: const TextStyle(color: Colors.white),),
          tileColor: Colors.black,
        ),
      );
    })
   );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
       // TODO: implement buildResults
      List<Meals> mealslist = Provider.of<MealsProvider>(context).meals;
      List<Meals> matchQuery=[];
      for(var meal in mealslist){
        if(meal.name.toLowerCase().contains(query.toLowerCase())){
             matchQuery.add(meal);
        }
      }
   return Container(
    color: Colors.black,
    child: 
    ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context,index){
      return GestureDetector(
        onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MealsInfoPage(meal: matchQuery[index])));
        },
        child: ListTile(contentPadding: const EdgeInsets.all(10),
          leading: ClipRRect(borderRadius: BorderRadius.circular(90), child: Image.network(matchQuery[index].image)) ?? const Icon(Icons.image),
          title: Text(matchQuery[index].name,style: const TextStyle(color: Colors.white),),
          tileColor: Colors.black,
        ),
      );
    })
   );
  }}
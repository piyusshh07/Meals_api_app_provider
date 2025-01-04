import 'package:flutter/material.dart';
import 'package:meals_api_app_/Model/Meals_model.dart';
import 'package:meals_api_app_/Provider/MealsProvider.dart';
import 'package:provider/provider.dart';

class MealsInfoPage extends StatelessWidget {
  const MealsInfoPage({super.key,required this.meal});
  final Meals meal;

  @override
  Widget build(BuildContext context) {
 final textstyle=const TextStyle(
  color: Colors.white,
  fontSize: 20
 );
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Consumer(builder: (ctxt, value, child) {
      final  mealsList=ctxt.watch<MealsProvider>().favoritemeals;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
            children: [
              const SizedBox(height: 20,),
              Stack(
                children: [
                  ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(meal.image),)
                 ,
                  Positioned(
                   bottom: 10,right: 10,
                    child: InkWell(
                      onTap: (){
                        mealsList.contains(meal) ? ctxt.read<MealsProvider>().removeFromFavorite(meal) :
                         ctxt.read<MealsProvider>().addToFavorite(meal);
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mealsList.contains(meal) ? 'Added To Favourites': "Removed From Favorites",),));
                       
                      },
                      child: Icon(mealsList.contains(meal) ? Icons.favorite : Icons.favorite_outline ,
                      color: mealsList.contains(meal) ? Colors.red : Colors.white,size: 30,),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Text(meal.name.toUpperCase(),style: textstyle.copyWith(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          
              Text('${meal.caloriesPerServing.toString()} cal per serving',style: textstyle,),
              Text('Cooking Time :${meal.cookTimeMinutes} mins',style:textstyle,),
              const SizedBox(height: 20,)
,
Text('Ingredients '.toUpperCase(),style: textstyle.copyWith(fontSize:30,fontWeight: FontWeight.bold),),
              Container(
                padding: const EdgeInsets.all(5),
                child: ListView.builder(
                  shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: meal.ingredients.length,
                  itemBuilder: (context,index){
                  return 
                  Text(meal.ingredients[index],style: textstyle,textAlign: TextAlign.center,);
                }),
              ),
              const SizedBox(height: 20,),
              Text('Cooking Steps'.toUpperCase(),style: textstyle.copyWith(fontSize: 30,fontWeight: FontWeight.bold),),
              const SizedBox(height: 5,),
              Container(
                    padding: const EdgeInsets.all(5),
                child: ListView.builder(
                  shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: meal.instructions.length,
                  itemBuilder: (context,index){
                  return 
                  Text('${index +1} .${meal.instructions[index]}',style: textstyle,textAlign: TextAlign.center,);
                }),
              ),
                     const SizedBox(height: 20,),
            ]),
          ),
        );
   } ));
  }
}
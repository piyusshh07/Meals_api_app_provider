import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_api_app/Meals_info.dart';
import 'package:meals_api_app/Meals_list.dart';
import 'package:meals_api_app/riverpod/riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Mealslist = ref.watch(mealsListProvider); // Accessing a provider

    return  Scaffold(
      backgroundColor: Colors.black,
appBar: AppBar(
  backgroundColor: Colors.black,
  foregroundColor: Colors.white,
  title: Text('Meals Receipes'),

  actions: [
    IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
  ],
),
      body: Mealslist.when(data: (Mealslist) {
      return  ListView.builder(
  itemCount: Mealslist.length,
  itemBuilder: (context,index){
    final meallist=Mealslist[index];
  return Padding(
    padding: EdgeInsets.all(10),
    child: Container(
child: GestureDetector(
  onTap: (){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MealsInfo(recipe: meallist,)));
  },
  child: Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      children: [
        SizedBox(
          height: 200,
          width: double.maxFinite,
          child: Image.network(meallist.image,fit: BoxFit.cover,)),
    Container(
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      color: Colors.black87,
      child: Column(
        children: [
          Text(meallist.name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
          Text("${meallist.caloriesPerServing.toString()} cal Per Serving",style: TextStyle(color: Colors.white,fontSize: 15),),
        ],
      ),
    )
    
      ],
    ),
  ),
)
    ),
  );
}
    );
        }, error: (Error, StackTrace)=> Text('Error ${Error}'), loading:()=> Center(child: CircularProgressIndicator(),))
    );
  }
}

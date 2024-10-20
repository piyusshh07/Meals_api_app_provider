// import 'package:flutter/material.dart';
// import 'package:meals_api_app/Meals_info.dart';
// import 'package:meals_api_app/Meals_model.dart';
// import 'package:meals_api_app/service_api.dart';

// class MealsList extends StatefulWidget {
//   const MealsList({super.key});

//   @override
//   State <MealsList> createState() =>  _MealsListState();
// }

// class  _MealsListState extends State <MealsList> {
//   List<Recipe> recipes=[];

//   GetMeals(){
//     getMeals().then((value) {
//         setState(() {
//     recipes=value;
//     });
    
//     });
  
//   }
//   @override
//   void initState() {
//     super.initState();
//     GetMeals();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
// appBar: AppBar(
//   backgroundColor: Colors.black,
//   foregroundColor: Colors.white,
//   title: Text('Meals Receipes'),

//   actions: [
//     IconButton(onPressed: (){}, icon: Icon(Icons.favorite))
//   ],
// ),
// body: ListView.builder(
//   itemCount: recipes.length,
//   itemBuilder: (context,index){
//   return Padding(
//     padding: EdgeInsets.all(10),
//     child: Container(
// child: GestureDetector(
//   onTap: (){
//     Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MealsInfo(recipe: recipes[index],)));
//   },
//   child: Container(
//     padding: EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.white),
//       borderRadius: BorderRadius.circular(10)
//     ),
//     child: Column(
//       children: [
//         SizedBox(
//           height: 200,
//           width: double.maxFinite,
//           child: Image.network(recipes[index].image,fit: BoxFit.cover,)),
//     Container(
//       padding: EdgeInsets.all(10),
//       width: double.maxFinite,
//       color: Colors.black87,
//       child: Column(
//         children: [
//           Text(recipes[index].name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
//           Text("${recipes[index].caloriesPerServing.toString()} cal Per Serving",style: TextStyle(color: Colors.white,fontSize: 15),),
//         ],
//       ),
//     )
    
//       ],
//     ),
//   ),
// )
//     ),
//   );
// })
//     );

//   }
// }
import 'package:flutter/material.dart';
import 'package:meals_api_app/Meals_model.dart';

class MealsInfo extends StatefulWidget {
  const MealsInfo({super.key, required this.recipe});
  final Recipe recipe;

  @override
  State<MealsInfo> createState() => _MealsInfoState();
}

class _MealsInfoState extends State<MealsInfo> {
List<Recipe> favorite=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image with error handling
              Stack(
                children: [Image.network(
                  widget.recipe.image,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 100, color: Colors.red);
                  },
                ),
                Align( alignment: Alignment.bottomRight,
                child: 
                IconButton(onPressed: (){
                  favorite.add(widget.recipe);
                  print(favorite);
                },icon:Icon(Icons.favorite_border_outlined),)
                )
            ]),
              const SizedBox(height: 10), // Reduced the space between the image and the text
              
              // Recipe Name
              Text(
                widget.recipe.name,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10), // Reduced the space between name and ingredients
              
              // Ingredients list
              Text(
                'Ingredients'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,decorationThickness: 2
                ),
              ),
              const SizedBox(height: 5), // Slight space between heading and list
              ListView.builder(
                shrinkWrap: true, // Prevent ListView from taking infinite height
                physics: NeverScrollableScrollPhysics(), // Disable internal scroll
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Text(
                      widget.recipe.ingredients[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 10), // Reduced the space between ingredients and instructions
              
              // Instructions list
              Text(
                'Instructions'.toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,decoration: TextDecoration.underline,
                  decorationColor: Colors.white,decorationThickness: 2
                ),
              ),
              const SizedBox(height: 5), // Slight space between heading and list
              ListView.builder(
                shrinkWrap: true, // Prevent ListView from taking infinite height
                physics: NeverScrollableScrollPhysics(), // Disable internal scroll
                itemCount: widget.recipe.instructions.length,
                itemBuilder: (context, index) {
                  return Text(
                    "${index + 1}. ${widget.recipe.instructions[index]}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

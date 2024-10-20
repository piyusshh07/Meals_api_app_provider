import 'package:flutter/material.dart';
import 'package:meals_api_app/Meals_info.dart';
import 'package:meals_api_app/Meals_model.dart';
import 'package:meals_api_app/service_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // List<Recipe> recipes = [];

  // GetMeals() {
  //   getMeals().then((value) {
  //     setState(() {
  //       recipes = value;
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   GetMeals();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Form(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)))),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)))),
            ],
          ),
        )));
  }
}

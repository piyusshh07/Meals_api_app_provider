 import 'package:flutter/material.dart';
import 'package:meals_api_app_/Screens/HomePage.dart';
import 'package:meals_api_app_/Provider/MealsProvider.dart';

import 'package:meals_api_app_/apiservice.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( ChangeNotifierProvider(
        create: (context) => MealsProvider(apiService: ApiService()),
        child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        primaryColor: Colors.teal,
        useMaterial3: true,
      ),
      home: const MyHomePage()
    );
  }
}

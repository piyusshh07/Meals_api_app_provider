import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_api_app/Homepage.dart';
import 'package:meals_api_app/Meals_list.dart';
import 'package:meals_api_app/login.dart';
    // Added this import

void main() {
  runApp(ProviderScope(child:MyApp()) );  // ProviderScope is correctly used here
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: HomeScreen(),  // This will be the initial screen
    );
  }
}

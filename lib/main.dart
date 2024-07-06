
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_assignment/provider/locations_provider.dart';
import 'package:weather_app_assignment/screens/loading_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LocationsProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: const LoadingScreen(),
    );
  }
}

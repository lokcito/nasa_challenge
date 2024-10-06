import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nasa_challenge/pages/prediction.dart';
import 'package:nasa_challenge/pages/weather.dart';
import 'dart:html' as html;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

//https://colorhunt.co/palette/7c93c355679c1e2a5ee1d7b7
void main() {
  runApp(const MyApp());
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return WeatherScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const PredictionScreen();
          },
        ),
      ],
    ),
  ],
);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primaryColor: const Color(
            0xFF123456), // Cambiar el color principal a uno específico
      ),
    );
  }
}

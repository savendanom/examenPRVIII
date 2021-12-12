import 'package:flutter/material.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:project_movies/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'details': (_) => DetailScreen(),
        'top': (_) => TopMovieScreen(),
        'rateddetails': (_) => TopRatedDetailScreen(),
        'similar': (_) => DetailSimilarScreen(),
        'company': (_) => CompanyScreen(),
      },
      theme: ThemeData.light(),
    );
  }
}

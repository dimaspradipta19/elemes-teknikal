import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/utils/splash_screen.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/upcoming_movie_provider.dart';
import 'package:technical_elemes/viewmodel/provider/navigationbar_provider.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/now_playing_movie_provider.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/search_movie_provider.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/top_rated_movie_provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/popular_tv_provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/search_tv_provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/top_rated_tv_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavigationBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopRatedMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NowPlayingMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TopRatedTvProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PopularTvProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UpcomingMovieProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchTvProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Movie Apps',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

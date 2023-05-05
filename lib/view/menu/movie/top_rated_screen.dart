import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/top_rated_movie_provider.dart';

class TopRatedMovieScreen extends StatefulWidget {
  const TopRatedMovieScreen({super.key});

  @override
  State<TopRatedMovieScreen> createState() => _TopRatedMovieScreenState();
}

class _TopRatedMovieScreenState extends State<TopRatedMovieScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TopRatedMovieProvider>(context, listen: false)
          .getTopRatedMovie();
    });
    super.initState();
  }

  String posterImage = "https://image.tmdb.org/t/p/original/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top Movie",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.amber[300],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            Expanded(child: Consumer<TopRatedMovieProvider>(
              builder: (context, valueTopMovie, child) {
                if (valueTopMovie.state == ResultState.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (valueTopMovie.state == ResultState.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: valueTopMovie.topRatedMovie!.results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                    height: 300,
                                    width: 300,
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator
                                            .adaptive(),
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        "$posterImage${valueTopMovie.topRatedMovie!.results[index].posterPath}"),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      "#${index + 1}",
                                      style: TextStyle(
                                          color: Colors.red[400],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return const Text("Error");
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/utils/enum.dart';
import '../../../viewmodel/provider/movieprovider/now_playing_movie_provider.dart';

class NowPlayingMovieScreen extends StatefulWidget {
  const NowPlayingMovieScreen({super.key});

  @override
  State<NowPlayingMovieScreen> createState() => _NowPlayingMovieScreen();
}

class _NowPlayingMovieScreen extends State<NowPlayingMovieScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NowPlayingMovieProvider>(context, listen: false)
          .getNowPlaying();
    });
    super.initState();
  }

  String posterImage = "https://image.tmdb.org/t/p/original/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Now Playing",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.amber[300],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            Expanded(child: Consumer<NowPlayingMovieProvider>(
              builder: (context, valueTopMovie, child) {
                if (valueTopMovie.state == ResultState.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (valueTopMovie.state == ResultState.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: valueTopMovie.nowPlayingMovie!.results.length,
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
                            child: CachedNetworkImage(
                                height: 300,
                                width: 300,
                                errorWidget: (context, url, error) =>
                                    const CircularProgressIndicator.adaptive(),
                                fit: BoxFit.fill,
                                imageUrl:
                                    "$posterImage${valueTopMovie.nowPlayingMovie!.results[index].posterPath}"),
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

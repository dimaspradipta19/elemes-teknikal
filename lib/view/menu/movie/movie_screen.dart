import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:shimmer/shimmer.dart";
import "package:technical_elemes/utils/enum.dart";
import "package:technical_elemes/view/menu/movie/now_playing_movie_screen.dart";
import 'package:technical_elemes/view/menu/movie/search_movie_screen.dart';
import "package:technical_elemes/view/menu/movie/top_rated_screen.dart";
import 'package:technical_elemes/viewmodel/provider/movieprovider/now_playing_movie_provider.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/top_rated_movie_provider.dart';
import "package:technical_elemes/viewmodel/provider/movieprovider/upcoming_movie_provider.dart";

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TopRatedMovieProvider>(context, listen: false)
          .getTopRatedMovie();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NowPlayingMovieProvider>(context, listen: false)
          .getNowPlaying();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UpcomingMovieProvider>(context, listen: false).getUpcoming();
    });
    super.initState();
  }

  String posterImage = "https://image.tmdb.org/t/p/original/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /* Background Yellow */
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.amber[300]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  /* Searchbar */
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 50.0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 5,
                          child: SearchWidget(),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                            child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red[400],
                            size: 32,
                          ),
                        )),
                      ],
                    ),
                  ),
                  /* End Searchbar */

                  /* Top Rated Movie */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated Movie",
                        style: GoogleFonts.poppins(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TopRatedMovieScreen(),
                                ));
                          },
                          child: const Text(
                            "See More",
                          ))
                    ],
                  ),
                  Consumer<TopRatedMovieProvider>(
                    builder: (context, TopRatedMovieProvider valueTopRatedMovie,
                        child) {
                      if (valueTopRatedMovie.state == ResultState.loading) {
                        // TODO: Fixing shimmer effect
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                        // Shimmer.fromColors(
                        //   baseColor: Colors.red,
                        //   highlightColor: Colors.green,
                        //   child: Container(
                        //     height: 300,
                        //     width: 300,
                        //     // child: ListView.builder(
                        //     //   shrinkWrap: true,
                        //     //   physics: const NeverScrollableScrollPhysics(),
                        //     //   itemBuilder: (context, index) {
                        //     //     return Container();
                        //     //   },
                        //     // ),
                        //   ),
                        // );
                      } else if (valueTopRatedMovie.state ==
                          ResultState.hasData) {
                        return SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: valueTopRatedMovie
                                .topRatedMovie!.results.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 100,
                                  width: 200,
                                  decoration:
                                      BoxDecoration(color: Colors.grey[100]),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            ),
                                            imageUrl:
                                                "$posterImage${valueTopRatedMovie.topRatedMovie!.results[index].posterPath}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text("Error");
                      }
                    },
                  ),
                  /* End Top Rated Movie */
                  const SizedBox(height: 20.0),

                  /* Now Playing Movie */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Now Playing Movie",
                        style: GoogleFonts.poppins(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NowPlayingMovieScreen(),
                                ));
                          },
                          child: const Text(
                            "See More",
                          ))
                    ],
                  ),
                  Consumer<NowPlayingMovieProvider>(
                    builder: (context, valueNowPlaying, child) {
                      if (valueNowPlaying.state == ResultState.loading) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (valueNowPlaying.state == ResultState.hasData) {
                        return SizedBox(
                          height: 600,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.6,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15),
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "$posterImage${valueNowPlaying.nowPlayingMovie!.results[index].posterPath}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    valueNowPlaying.nowPlayingMovie
                                            ?.results[index].title ??
                                        "",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text("Error");
                      }
                    },
                  ),
                  /* End Now Playing Movie */

                  /* Upcoming movie */
                  Consumer<UpcomingMovieProvider>(
                    builder: (context, UpcomingMovieProvider valueUpcomingMovie,
                        child) {
                      if (valueUpcomingMovie.state == ResultState.loading) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      } else if (valueUpcomingMovie.state ==
                          ResultState.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Upcoming Movie",
                                ),
                                Expanded(child: Container()),
                                Row(
                                  children: [
                                    Text(
                                      valueUpcomingMovie
                                          .upcomingMovie!.dates.minimum.day
                                          .toString(),
                                    ),
                                    const Text("-"),
                                    Text(
                                      valueUpcomingMovie
                                          .upcomingMovie!.dates.minimum.month
                                          .toString(),
                                    ),
                                    const Text("-"),
                                    Text(
                                      valueUpcomingMovie
                                          .upcomingMovie!.dates.minimum.year
                                          .toString(),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text("S/D"),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      valueUpcomingMovie
                                          .upcomingMovie!.dates.maximum.day
                                          .toString(),
                                    ),
                                    const Text("-"),
                                    Text(
                                      valueUpcomingMovie
                                          .upcomingMovie!.dates.maximum.month
                                          .toString(),
                                    ),
                                    const Text("-"),
                                    Text(
                                      valueUpcomingMovie
                                          .upcomingMovie!.dates.maximum.year
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                
                                child: ListView.builder(
                                  itemCount: valueUpcomingMovie
                                      .upcomingMovie!.results.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: SizedBox(
                                        height: 100,
                                        width: 200,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator
                                                            .adaptive(),
                                                  ),
                                                  imageUrl:
                                                      "$posterImage${valueUpcomingMovie.upcomingMovie!.results[index].posterPath}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ))
                          ],
                        );
                      } else {
                        return const Text("No Data");
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white),
      child: Form(
        child: TextFormField(
          readOnly: true,
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchMovieScreen(),
              )),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
            contentPadding: EdgeInsets.only(left: 20.0),
          ),
        ),
      ),
    );
  }
}

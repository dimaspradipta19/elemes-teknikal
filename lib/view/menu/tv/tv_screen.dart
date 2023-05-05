import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/view/menu/tv/popular_tv_screen.dart';
import 'package:technical_elemes/view/menu/tv/search_tv_screen.dart';
import 'package:technical_elemes/view/menu/tv/top_rated_tv_screen.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/popular_tv_provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/top_rated_tv_provider.dart';

import '../../../utils/enum.dart';
import '../movie/movie_screen.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TopRatedTvProvider>(context, listen: false).getTopRatedTv();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PopularTvProvider>(context, listen: false).getPopularTv();
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
                          child: SearchTvWidget(),
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

                  /* Top Rated TV */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Rated Tv",
                        style: GoogleFonts.poppins(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TopRatedTvScreen(),
                                ));
                          },
                          child: const Text(
                            "See More",
                          ))
                    ],
                  ),
                  Consumer<TopRatedTvProvider>(
                    builder: (context, TopRatedTvProvider valueTopRatedMovie,
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
                                .topRatedTvModel!.results.length,
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
                                                "$posterImage${valueTopRatedMovie.topRatedTvModel!.results[index].posterPath}",
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

                  /* Popular Tv */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular TV show",
                        style: GoogleFonts.poppins(),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PopularTvScreen(),
                                ));
                          },
                          child: const Text(
                            "See More",
                          ))
                    ],
                  ),
                  Consumer<PopularTvProvider>(
                    builder:
                        (context, PopularTvProvider valuePopularTv, child) {
                      if (valuePopularTv.state == ResultState.loading) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (valuePopularTv.state == ResultState.hasData) {
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
                                          "$posterImage${valuePopularTv.popularTvModel!.results[index].posterPath}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Text(
                                    valuePopularTv.popularTvModel
                                            ?.results[index].name ??
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SearchTvWidget extends StatelessWidget {
  const SearchTvWidget({
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
                builder: (context) => const SearchTvScreen(),
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

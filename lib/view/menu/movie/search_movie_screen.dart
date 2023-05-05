import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/provider/movieprovider/search_movie_provider.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  final TextEditingController _searchController = TextEditingController();
  String posterImage = "https://image.tmdb.org/t/p/original/";

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios))),
                  Expanded(
                    flex: 5,
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.white),
                      child: Form(
                        child: TextFormField(
                          controller: _searchController,
                          style: const TextStyle(fontSize: 12.0),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: const TextStyle(fontSize: 12.0),
                            contentPadding:
                                const EdgeInsets.only(left: 20.0, top: 18.0),
                            suffixIcon: IconButton(
                              onPressed: () {
                                Provider.of<SearchMovieProvider>(context,
                                        listen: false)
                                    .getSearchMovie(_searchController.text);
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<SearchMovieProvider>(
                builder: (context, valueSearchMovie, child) {
                  if (valueSearchMovie.state == ResultState.loading) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (valueSearchMovie.state == ResultState.hasData) {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      itemCount: valueSearchMovie.searchMovie!.results.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          width: 200,
                          child: Column(
                            children: [
                              Expanded(
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator
                                            .adaptive(),
                                    imageUrl:
                                        "$posterImage${valueSearchMovie.searchMovie?.results[index].backdropPath}"),
                              ),
                              Text(valueSearchMovie
                                  .searchMovie!.results[index].title)
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

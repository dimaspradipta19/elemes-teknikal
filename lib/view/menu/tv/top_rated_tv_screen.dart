import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/top_rated_tv_provider.dart';

import '../../../utils/enum.dart';

class TopRatedTvScreen extends StatefulWidget {
  const TopRatedTvScreen({super.key});

  @override
  State<TopRatedTvScreen> createState() => _TopRatedTvScreenState();
}

class _TopRatedTvScreenState extends State<TopRatedTvScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TopRatedTvProvider>(context, listen: false).getTopRatedTv();
    });
    super.initState();
  }

  String posterImage = "https://image.tmdb.org/t/p/original/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Top Rated Tv",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.amber[300],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            Expanded(child: Consumer<TopRatedTvProvider>(
              builder: (context, valueTopRatedTv, child) {
                if (valueTopRatedTv.state == ResultState.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (valueTopRatedTv.state == ResultState.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: valueTopRatedTv.topRatedTvModel!.results.length,
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
                                        "$posterImage${valueTopRatedTv.topRatedTvModel!.results[index].posterPath}"),
                                Container(
                                  height: 40.0,
                                  width: 40.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      valueTopRatedTv.topRatedTvModel!.results[index].voteAverage.toString(),
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

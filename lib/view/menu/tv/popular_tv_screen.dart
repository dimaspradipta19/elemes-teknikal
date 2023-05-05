import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/popular_tv_provider.dart';

import '../../../utils/enum.dart';

class PopularTvScreen extends StatefulWidget {
  const PopularTvScreen({super.key});

  @override
  State<PopularTvScreen> createState() => _PopularTvScreenState();
}

class _PopularTvScreenState extends State<PopularTvScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PopularTvProvider>(context, listen: false).getPopularTv();
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
            Expanded(child: Consumer<PopularTvProvider>(
              builder: (context, valuePopularTv, child) {
                if (valuePopularTv.state == ResultState.loading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (valuePopularTv.state == ResultState.hasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: valuePopularTv.popularTvModel!.results.length,
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
                                    "$posterImage${valuePopularTv.popularTvModel!.results[index].posterPath}"),
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

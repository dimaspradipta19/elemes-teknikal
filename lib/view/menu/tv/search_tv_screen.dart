import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_elemes/viewmodel/provider/tvprovider/search_tv_provider.dart';

import '../../../utils/enum.dart';

class SearchTvScreen extends StatefulWidget {
  const SearchTvScreen({super.key});

  @override
  State<SearchTvScreen> createState() => _SearchTvScreenState();
}

class _SearchTvScreenState extends State<SearchTvScreen> {
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
                                Provider.of<SearchTvProvider>(context,
                                        listen: false)
                                    .getSearchTv(_searchController.text);
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
              child: Consumer<SearchTvProvider>(
                builder: (context, valueSearchTv, child) {
                  if (valueSearchTv.state == ResultState.loading) {
                    return const CircularProgressIndicator.adaptive();
                  } else if (valueSearchTv.state == ResultState.hasData) {
                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      itemCount: valueSearchTv.searchTvModel!.results.length,
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
                                        "$posterImage${valueSearchTv.searchTvModel?.results[index].posterPath}"),
                              ),
                              Text(valueSearchTv
                                  .searchTvModel!.results[index].name)
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

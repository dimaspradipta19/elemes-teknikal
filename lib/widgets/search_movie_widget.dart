import 'package:flutter/material.dart';

import '../view/menu/movie/search_movie_screen.dart';

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
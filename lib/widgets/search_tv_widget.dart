import 'package:flutter/material.dart';

import '../view/menu/tv/search_tv_screen.dart';

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
import 'dart:convert';

import 'package:technical_elemes/model/moviemodel/search_movie_model.dart';
import 'package:http/http.dart' as http;

class SearchMovieService {
  Future<SearchMovieModel?> getSearch(String movieName) async {
    try {
      String url =
          "https://api.themoviedb.org/3/search/movie?api_key=4c65dcd30f0b84629a0af3d4802ab464&language=en-US&query=$movieName%20america&page=1&include_adult=false";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        var result = SearchMovieModel.fromJson(decodedJson);
        return result;
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

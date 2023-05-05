import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technical_elemes/model/moviemodel/top_rated_movie_model.dart';

class TopRatedMovieService {
  Future<TopRatedMovieModel?> getTopRatedMovie() async {
    // TopRatedMovieModel? resultAwal;
    try {
      const String url =
          "https://api.themoviedb.org/3/movie/top_rated?api_key=4c65dcd30f0b84629a0af3d4802ab464&language=en-US&page=1";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        var result = TopRatedMovieModel.fromJson(decodedJson);
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

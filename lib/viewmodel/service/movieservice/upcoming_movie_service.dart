import 'dart:convert';

import 'package:technical_elemes/model/moviemodel/upcoming_movie_model.dart';
import 'package:http/http.dart' as http;

class UpcomingMovieService {
  Future<UpcomingMovieModel?> getUpcomingMovie() async {
    try {
      const String url =
          "https://api.themoviedb.org/3/movie/upcoming?api_key=4c65dcd30f0b84629a0af3d4802ab464&language=en-US&page=1";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        var result = UpcomingMovieModel.fromJson(decodedJson);
        return result;
      } else {
        throw Exception("Error code: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}

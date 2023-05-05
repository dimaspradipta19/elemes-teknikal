import 'dart:convert';

import 'package:technical_elemes/model/tvmodel/search_tv_model.dart';
import 'package:http/http.dart' as http;

class SearchTvService {
  Future<SearchTvModel?> getSearchTv(String tvShowName) async {
    try {
      String url =
          "https://api.themoviedb.org/3/search/tv?api_key=4c65dcd30f0b84629a0af3d4802ab464&language=en-US&page=1&query=$tvShowName&include_adult=false";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        var result = SearchTvModel.fromJson(decodedJson);
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

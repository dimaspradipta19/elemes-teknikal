import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technical_elemes/model/tvmodel/popular_tv_model.dart';

class PopularTvService {
  Future<PopularTvModel?> getPopularTv() async {
    try {
      const String url =
          "https://api.themoviedb.org/3/tv/popular?api_key=4c65dcd30f0b84629a0af3d4802ab464&language=en-US&page=1";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var decodedJson = jsonDecode(response.body);
        var result = PopularTvModel.fromJson(decodedJson);
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

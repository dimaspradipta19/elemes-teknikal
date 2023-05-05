import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/moviemodel/search_movie_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/movieservice/search_movie_service.dart';

class SearchMovieProvider with ChangeNotifier {
  SearchMovieService service = SearchMovieService();
  SearchMovieModel? searchMovie;
  ResultState state = ResultState.noData;

  Future<dynamic> getSearchMovie(String movieName) async {
    try {
      state = ResultState.loading;
      notifyListeners();
      searchMovie = await service.getSearch(movieName);
      if (searchMovie == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw Exception("Error load the data");
    } catch (e) {
      rethrow;
    }
    return null;
  }
}

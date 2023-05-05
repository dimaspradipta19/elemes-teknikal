import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/moviemodel/top_rated_movie_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/movieservice/top_rated_movie_service.dart';

class TopRatedMovieProvider with ChangeNotifier {
  TopRatedMovieService service = TopRatedMovieService();
  TopRatedMovieModel? topRatedMovie;
  ResultState state = ResultState.noData;

  Future<dynamic> getTopRatedMovie() async {
    try {
      state = ResultState.loading;
      notifyListeners();
      topRatedMovie = await service.getTopRatedMovie();

      if (topRatedMovie == null) {
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
  }
}

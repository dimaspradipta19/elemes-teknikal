import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/moviemodel/upcoming_movie_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/movieservice/upcoming_movie_service.dart';

class UpcomingMovieProvider with ChangeNotifier {
  UpcomingMovieService service = UpcomingMovieService();
  UpcomingMovieModel? upcomingMovie;
  ResultState state = ResultState.noData;

  Future<dynamic> getUpcoming() async {
    try {
      state = ResultState.loading;
      notifyListeners();

      upcomingMovie = await service.getUpcomingMovie();
      if (upcomingMovie == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw Exception("Error fetch Data");
    } catch (e) {
      rethrow;
    }
  }
}

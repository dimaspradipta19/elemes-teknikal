import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/moviemodel/now_playing_movie_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/movieservice/now_playing_movie_service.dart';

class NowPlayingMovieProvider with ChangeNotifier {
  NowPlayingMovieService service = NowPlayingMovieService();
  NowPlayingMovieModel? nowPlayingMovie;
  ResultState state = ResultState.noData;

  Future<dynamic> getNowPlaying() async {
    try {
      state = ResultState.loading;
      notifyListeners();
      nowPlayingMovie = await service.getNowPlayingMovie();
      if (nowPlayingMovie == null) {
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

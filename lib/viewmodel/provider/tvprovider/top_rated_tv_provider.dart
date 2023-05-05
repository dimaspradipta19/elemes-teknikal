import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/tvmodel/top_rated_tv_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/tvservice/top_rated_tv_service.dart';

class TopRatedTvProvider with ChangeNotifier {
  TopRatedTvService service = TopRatedTvService();
  TopRatedTvModel? topRatedTvModel;
  ResultState state = ResultState.noData;

  Future<dynamic> getTopRatedTv() async {
    try {
      state = ResultState.loading;
      notifyListeners();
      topRatedTvModel = await service.getTopRatedTv();
      if (topRatedTvModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw Exception("Error fetch the Data");
    } catch (e) {
      rethrow;
    }
  }
}

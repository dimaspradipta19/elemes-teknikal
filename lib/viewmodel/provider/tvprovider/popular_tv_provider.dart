import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/tvmodel/popular_tv_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/tvservice/popular_tv_service.dart';

class PopularTvProvider with ChangeNotifier {
  PopularTvService service = PopularTvService();
  PopularTvModel? popularTvModel;
  ResultState state = ResultState.noData;

  Future<dynamic> getPopularTv() async {
    try {
      state = ResultState.loading;
      notifyListeners();
      popularTvModel = await service.getPopularTv();

      if (popularTvModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      throw Exception("Cannot fetch the data");
    } catch (e) {
      rethrow;
    }
  }
}

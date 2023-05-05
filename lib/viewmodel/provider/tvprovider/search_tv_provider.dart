import 'dart:io';

import 'package:flutter/material.dart';
import 'package:technical_elemes/model/tvmodel/search_tv_model.dart';
import 'package:technical_elemes/utils/enum.dart';
import 'package:technical_elemes/viewmodel/service/tvservice/search_tv_service.dart';

class SearchTvProvider with ChangeNotifier {
  SearchTvService service = SearchTvService();
  SearchTvModel? searchTvModel;
  ResultState state = ResultState.noData;

  Future<dynamic> getSearchTv(String tvShowName) async {
    try {
      state = ResultState.loading;
      notifyListeners();

      searchTvModel = await service.getSearchTv(tvShowName);
      if (searchTvModel == null) {
        state = ResultState.noData;
        notifyListeners();
      } else {
        state = ResultState.hasData;
        notifyListeners();
      }
      notifyListeners();
    } on SocketException {
      ("Cannot fetch the data");
    } catch (e) {
      rethrow;
    }
  }
}

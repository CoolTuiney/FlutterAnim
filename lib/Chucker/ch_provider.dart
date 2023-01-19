import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChuckerHttpProvider extends ChangeNotifier {
  final List<http.Response> _httpResponseList = [];
  List<http.Response> get getHttpResList => _httpResponseList;

  void addResponse(http.Response res) {
    _httpResponseList.add(res);
    notifyListeners();
  }
}

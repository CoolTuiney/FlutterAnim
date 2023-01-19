import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation/Chucker/ch_provider.dart';
import 'package:flutter_animation/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


class ApiClass {
  var url = "https://jsonplaceholder.typicode.com/todos/1";
  Future<void> callSampleAPI(BuildContext context) async {
    try {
      final _chuckerHttpClient = ChuckerHttpClient(http.Client());

      var chuckerHttpProvider =
          Provider.of<ChuckerHttpProvider>(context, listen: false);
      var res = await _chuckerHttpClient.get(Uri.parse(url));

      debugPrint(res.body);
      chuckerHttpProvider.addResponse(res);
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
}

import 'dart:async';

import 'package:grab_demo/cofig/key.dart';
import 'package:grab_demo/model/Place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class PlaceService {
  static Future<List<Place>> searchPlace(String keyword) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?key=" +
            key +
            "&language=vi&region=VN&query=" +
            Uri.encodeQueryComponent(keyword);
    var res = await http.get(url);
    if(res.statusCode==200)
      return Place.fromJson(json.decode(res.body));
    else return new List();
  }
}

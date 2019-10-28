import 'dart:async';

import 'package:grab_demo/repository/place_service.dart';

class PlaceBloc{
  var _placeController=StreamController();
  Stream get placeStream=>_placeController.stream;
  void searchPlace(String keyword){
    _placeController.sink.add("start");
    PlaceService.searchPlace(keyword).then((res){
      _placeController.sink.add(res);
    }).catchError((err){
      print(err);
    });
  }
  void dispose(){
    _placeController.close();
  }
}
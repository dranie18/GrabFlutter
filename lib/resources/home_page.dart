import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_demo/model/Place.dart';
import 'package:grab_demo/model/step_res.dart';
import 'package:grab_demo/model/trip_info_res.dart';
import 'package:grab_demo/repository/place_service.dart';
import 'package:grab_demo/resources/picker_page.dart';
import 'package:grab_demo/widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<StatefulWidget> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  final Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Set<Polyline> polylines = {};
  GoogleMapController mapController;
  var tripDistance=0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                this.mapController = controller;
              },
              initialCameraPosition:
              CameraPosition(target: LatLng(10.79, 106.72), zoom: 14.74),
              markers: Set<Marker>.of(markers.values),
              polylines: polylines,
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    leading: FlatButton(
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                      child: Icon(Icons.menu),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: fromController,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  height: 40,
                                  width: 40,
                                  child: IconButton(
                                    icon: Icon(Icons.my_location,
                                        color: Color(0xff289245)),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PickerPage(
                                                      onPlaceSelected, null,
                                                      true)));
                                    },
                                  ),
                                ),
                                suffixIcon: Container(
                                  height: 40,
                                  width: 40,
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      fromController.text = "";
                                    },
                                  ),
                                ),
                                hintText: "Điểm đi"),
                          ),
                          TextField(
                            controller: toController,
                            decoration: InputDecoration(
                                prefixIcon: Container(
                                  width: 40,
                                  height: 40,
                                  child: IconButton(
                                    icon: Icon(Icons.location_on,
                                      color: Color(0xff289245),),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PickerPage(
                                                      onPlaceSelected, null,
                                                      false)));
                                    },
                                  ),
                                ),
                                suffixIcon: Container(
                                  height: 40,
                                  width: 40,
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      toController.text = "";
                                    },
                                  ),
                                ),
                                hintText: "Điểm đến"),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeDrawer(),
      ),
    );
  }

  void onPlaceSelected(Place place, bool fromAdd) {
    String marker = fromAdd ? "from" : "to";
    setState(() {
      if (fromAdd)
        fromController.text = place.name;
      else
        toController.text = place.name;
    });
    addMarker(marker, place);
    moveCamera();
    drawPolyLine();
  }

  void addMarker(String strMarkerId, Place place) async {
    final MarkerId markerId = MarkerId(strMarkerId);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
            place.lat, place.lng
        ),
        infoWindow: InfoWindow(title: strMarkerId, snippet: '*')
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void moveCamera() {
    if (markers.values.length > 1) {
      var fromLatLng = markers[MarkerId("from")].position;
      var toLatLng = markers[MarkerId("to")].position;
      var sLat, sLng, nLat, nLng;
      if (fromLatLng.latitude <= toLatLng.latitude) {
        sLat = fromLatLng.latitude;
        nLat = toLatLng.latitude;
      } else {
        sLat = toLatLng.latitude;
        nLat = fromLatLng.latitude;
      }

      if (fromLatLng.longitude <= toLatLng.longitude) {
        sLng = fromLatLng.longitude;
        nLng = toLatLng.longitude;
      } else {
        sLng = toLatLng.longitude;
        nLng = fromLatLng.longitude;
      }
      LatLngBounds bounds = LatLngBounds(
          northeast: LatLng(nLat, nLng), southwest: LatLng(sLat, sLng));
      mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    } else {
      mapController.animateCamera(CameraUpdate.newLatLng(markers.values
          .elementAt(0)
          .position));
    }
  }

  void drawPolyLine() {
    if (markers.values.length > 1) {
        var from=markers[MarkerId("from")].position;;
        var to=markers[MarkerId("to")].position;;
        PlaceService.getStep(from.latitude, from.longitude, to.latitude, to.longitude).then((res){
          TripInfoRes infoRes=res;
          tripDistance=infoRes.distance;
          setState(() {
            List<StepsRes>rs=infoRes.steps;
            List<LatLng>paths=new List();
            for(var t in rs){
              paths.add(LatLng(t.startLocation.latitude,t.startLocation.longitude));
              paths.add(LatLng(t.endLocation.latitude,t.endLocation.longitude));
            }
            polylines.add(Polyline(
              points: paths,
              color: Colors.red
            ));
          });
        });
    }
  }
}

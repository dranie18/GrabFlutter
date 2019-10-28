import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grab_demo/model/Place.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: LatLng(10.79, 106.72), zoom: 14.74),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Color(0xff289245),
                    elevation: 0,
                    title: Text("Grab"),
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
                                prefixIcon: FlatButton(
                                  child: Icon(Icons.my_location),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PickerPage(
                                                onPlaceSelected, null, true)));
                                  },
                                ),
                                suffixIcon: FlatButton(
                                  child: Icon(Icons.close),
                                  onPressed: () {
                                    fromController.text = "";
                                  },
                                ),
                                hintText: "Điểm đi"),
                          ),
                          TextField(
                            controller: toController,
                            decoration: InputDecoration(
                                prefixIcon: FlatButton(
                                  child: Icon(Icons.location_on),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => PickerPage(
                                                onPlaceSelected, null, false)));
                                  },
                                ),
                                suffixIcon: FlatButton(
                                  child: Icon(Icons.close),
                                  onPressed: () {
                                    toController.text = "";
                                  },
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
    setState(() {
      if (fromAdd)
        fromController.text = place.name;
      else
        toController.text = place.name;
    });
  }
}

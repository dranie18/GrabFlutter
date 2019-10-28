import 'package:flutter/material.dart';
import 'package:grab_demo/blocs/place_bloc.dart';
import 'package:grab_demo/model/Place.dart';

class PickerPage extends StatefulWidget {
  final String selectedAddress;
  final Function(Place, bool) onSelected;
  final bool isFromAddress;
  PickerPage(this.onSelected, this.selectedAddress, this.isFromAddress);


  @override
  State<PickerPage> createState() {
    // TODO: implement createState
    return PickerPageState();
  }
}

class PickerPageState extends State<PickerPage> {
  PlaceBloc placeBloc = PlaceBloc();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    placeBloc.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff289245),
      ),
      body: Container(
        color: Colors.white,
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: addressController,
                onSubmitted: (str) {
                  placeBloc.searchPlace(str);
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.map,color: Color(0xff289245),),
                    suffixIcon: Container(
                      height: 40,
                      width: 40,
                      child: FlatButton(
                        child: Icon(Icons.close),
                        onPressed: () {
                          addressController.text = "";
                        },
                      ),
                    ),
                    hintText: "Nhập địa điểm"),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: StreamBuilder(
                  stream: placeBloc.placeStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == "start")
                        return Center(
                          child: CircularProgressIndicator(),
                        );}
                      List<Place> placeList = snapshot.data;
                      print(placeList?.length??0);
                      return SafeArea(
                        child: ListView.separated(
                            itemBuilder: (context, index) => ListTile(
                                  title: Text(placeList.elementAt(index).name),
                                  subtitle:
                                      Text(placeList.elementAt(index).address),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    widget.onSelected(placeList.elementAt(index),widget.isFromAddress);
                                  },
                                ),
                            separatorBuilder: (context, index) => Divider(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                            itemCount: placeList?.length??0),
                      );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

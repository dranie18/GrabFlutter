class Place {
  String name;
  String address;
  double lat;
  double lng;

  Place(this.name, this.address, this.lat, this.lng);

  static List<Place> fromJson(Map<String, dynamic> json) {
    List<Place> placeList = new List();
    var results = json['results'] as List;
    for (var item in results) {
      var place = new Place(
          item['name'],
          item['formatted_address'],
          item['geometry']['location']['lat'],
          item['geometry']['location']['lng']);
      placeList.add(place);
    }
    return placeList;
  }
}

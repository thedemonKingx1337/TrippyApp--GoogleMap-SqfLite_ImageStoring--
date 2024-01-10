import 'dart:io';

import 'package:flutter/foundation.dart';
import '../helpers/location_helper.dart';
import '../helpers/db_sqfLite.dart';

import '../models/placeModel.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);

    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: pickedTitle,
        location: updatedLocation,
        image: pickedImage);

    _items.add(newPlace);

    notifyListeners();

    SQLHelper.insert("user_places", {
      "id": newPlace.id,
      "title": newPlace.title,
      "image": newPlace.image.path,
      "loc_lat": newPlace.location!.latitude,
      "loc_lng": newPlace.location!.longitude,
      "address": newPlace.location!.address,
    });
  }

  Future<void> fetchAndSetPlacesData() async {
    final dbDataList = await SQLHelper.fetchData("user_places");
    _items = dbDataList
        .map((e) => Place(
              id: e["id"],
              title: e["title"],
              location: PlaceLocation(
                  latitude: e["loc_lat"],
                  longitude: e["loc_lng"],
                  address: e["address"]),
              image: File(e["image"]),
            ))
        .toList();
    notifyListeners();
  }
}

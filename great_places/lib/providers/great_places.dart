import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:uuid/uuid.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItem(int index) {
    return _items[index];
  }

  Future<void> addItem(String title, File image, LatLng position) async {
    var address = await LocationUtil.getAddressFrom(position);
    var uuid = const Uuid();

    final place = Place(
      id: uuid.v4(),
      title: title,
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        address,
      ),
    );

    await DbUtil.insert('places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'latitude': place.location.latitude,
      'longitude': place.location.longitude,
      'address': place.location.address,
    });
    _items.add(place);
    notifyListeners();
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              location: PlaceLocation(
                latitude: item['latitude'],
                longitude: item['longitude'],
                item['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}

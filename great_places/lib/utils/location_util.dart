import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const googleAPIKey = '<your api key from google>';

class LocationUtil {
  static Future<String> generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) async {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$googleAPIKey';
  }

  static Future<String> getAddressFrom(LatLng position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleAPIKey');

    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}

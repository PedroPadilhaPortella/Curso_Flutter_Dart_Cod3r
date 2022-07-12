import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  LocationInput(this.onSelectPosition, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  LatLng? _selectedPosition;

  void showPreview(double latitude, double longitude) async {
    final staticMapImageUrl = await LocationUtil.generateLocationPreviewImage(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
      _selectedPosition = LatLng(latitude, longitude);
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final LocationData locData = await Location().getLocation();
    showPreview(locData.latitude!, locData.longitude!);
    final LatLng location = LatLng(locData.latitude!, locData.longitude!);
    widget.onSelectPosition(location);
  }

  Future<void> _selectOnMap() async {
    LatLng position = const LatLng(0, 0);

    if (_selectedPosition == null) {
      position = await Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MapScreen()),
      );
    } else {
      setState(() {
        position = LatLng(
          _selectedPosition!.latitude,
          _selectedPosition!.longitude,
        );
      });
      position = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MapScreen(
            initialLocation: PlaceLocation(
                latitude: position.latitude, longitude: position.longitude, ''),
          ),
        ),
      );
    }

    showPreview(position.latitude, position.longitude);
    widget.onSelectPosition(position);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? const Text('Localização não informada.')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Localização Atual'),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                elevation: 0,
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Selecione no mapa'),
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                elevation: 0,
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}

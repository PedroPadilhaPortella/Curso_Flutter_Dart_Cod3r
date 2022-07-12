import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';

class MapScreen extends StatefulWidget {
  PlaceLocation initialLocation;
  final bool isReadonly;

  MapScreen({
    Key? key,
    this.initialLocation = const PlaceLocation(
      latitude: -23.5677666,
      longitude: -46.6487763,
      '',
    ),
    this.isReadonly = false,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione'),
        actions: [
          if (widget.isReadonly == false)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pop(_pickedPosition);
              },
            )
        ],
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.initialLocation.toLatLng(),
            zoom: 15,
          ),
          onTap: widget.isReadonly ? null : _selectPosition,
          markers: {
            if (_pickedPosition != null && widget.isReadonly == false)
              Marker(
                markerId: const MarkerId('p1'),
                position: _pickedPosition!,
              ),
            if (_pickedPosition == null)
              Marker(
                markerId: const MarkerId('p1'),
                position: widget.initialLocation.toLatLng(),
              )
          }),
    );
  }
}

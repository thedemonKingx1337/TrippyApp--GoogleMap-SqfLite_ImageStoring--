import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../screens/map_fullScreen.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final mapPreviewURL = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: lng);
    setState(() {
      _previewImageUrl = mapPreviewURL.toString();
    });
  }

  Future<void> _getCurrentLocatin() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude!, locationData.longitude!);
      widget.onSelectPlace(locationData.latitude, locationData.longitude);
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
    print(selectedLocation.toString());
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(border: Border.all(width: 1)),
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  "No Location",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _getCurrentLocatin,
                icon: Icon(Icons.location_city),
                label: Text("Current Location"),
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                label: Text("Select from Map"),
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
              ),
            )
          ],
        )
      ],
    );
  }
}

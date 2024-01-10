import 'dart:io';

import 'package:flutter/material.dart';
import '../models/placeModel.dart';
import '../widgets/location_input.dart';
import 'package:provider/provider.dart';

import '../widgets/imageInput.dart';
import '../providers/places.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/addPlace";
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double? lat, double? lng) {
    _pickedLocation = PlaceLocation(latitude: lat!, longitude: lng!);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Place")),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                    decoration: InputDecoration(labelText: "Title"),
                    controller: _titleController),
                SizedBox(height: 10),
                ImageInput(_selectImage),
                SizedBox(height: 10),
                LocationInput(_selectPlace),
              ],
            ),
          ),
        )),
        ElevatedButton.icon(
          onPressed: _savePlace,
          icon: Icon(Icons.add),
          label: Text("Add Place"),
          style: ButtonStyle(),
        ),
      ]),
    );
  }
}

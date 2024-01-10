import 'package:flutter/material.dart';
import 'map_fullScreen.dart';
import 'package:provider/provider.dart';
import '../providers/places.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = "/place-detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false)
        .findById(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 5),
        Text(
          selectedPlace.location?.address ?? 'No address available',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => MapScreen(
                      initialLocation: selectedPlace.location!,
                      isSelecting: false,
                    )));
          },
          child: Text("View on Map"),
        )
      ]),
    );
  }
}

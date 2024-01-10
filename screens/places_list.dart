import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import 'add_placeScreen.dart';
import 'place_detailScreen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Destinations of life"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlacesData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(child: Text("No Data available.Add some")),
                builder: (context, greatPlaces_value, ch) => greatPlaces_value
                            .items.length <=
                        0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces_value.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    greatPlaces_value.items[index].image)),
                            title: Text(greatPlaces_value.items[index].title),
                            subtitle: Text(greatPlaces_value
                                    .items[index].location?.address ??
                                "No address available"),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailsScreen.routeName,
                                  arguments: greatPlaces_value.items[index].id);
                            },
                          );
                        },
                      )),
      ),
    );
  }
}

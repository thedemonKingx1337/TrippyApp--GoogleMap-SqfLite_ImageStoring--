import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/places_list.dart';
import 'screens/add_placeScreen.dart';
import 'providers/places.dart';
import 'screens/place_detailScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GreatPlaces>(
        create: (context) => GreatPlaces(),
        child: MaterialApp(
          home: PlacesListScreen(),
          routes: {
            AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
            PlaceDetailsScreen.routeName: (context) => PlaceDetailsScreen(),
          },
        ));
  }
}

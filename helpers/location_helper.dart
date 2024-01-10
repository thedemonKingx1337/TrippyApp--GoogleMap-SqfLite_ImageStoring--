import 'dart:convert';
import 'package:http/http.dart' as http;

const GOOGLE_API = "  ";

class LocationHelper {
  static String generateLocationPreviewImage(
      {double? latitude, double? longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API&signature=YOUR_SIGNATURE';
  }

  static Future<String> getPlaceAddress(double? lat, double? lng) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng &key=$GOOGLE_API";
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)["result"][0]["formatted_address"];
  }
}

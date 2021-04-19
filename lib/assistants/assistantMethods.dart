import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:log_in/assistants/requestAssistant.dart';
import 'package:log_in/configMaps.dart';
import 'package:log_in/dataHandler/appData.dart';
import 'package:log_in/models/address.dart';
import 'package:log_in/models/directDetails.dart';
import 'package:provider/provider.dart';
import 'package:log_in/screens/searchScreen.dart';

class assistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress;
    String st1, st2, st3, st4, st5;
    //Polyline polyline;

    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyATwnp3e3ZL7__Oskpdo8Gutgls6ir4FeU";

    var response = await RequestAssistant.getRequest(url);

    if (response != 'failed') {
      //complete address
      //placeAddress = response["results"][0]["formatted_address"];
      //['address_components'][0] for houseno, [1] for street address
      st1 = response["results"][0]["address_components"][2]["long_name"];
      st2 = response["results"][0]["address_components"][3]["long_name"];
      st3 = response["results"][0]["address_components"][4]["long_name"];
      st4 = response["results"][0]["address_components"][5]["long_name"];
      st5 = response["results"][0]["address_components"][6]["long_name"];

      placeAddress = st1 + ', ' + st2 + ', ' + st3 + ', ' + st4 + ', ' + st5;

      Address userPickUpAddress = new Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];

    directionDetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];

    directionDetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }
}

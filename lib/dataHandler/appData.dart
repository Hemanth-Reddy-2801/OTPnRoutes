import 'package:flutter/material.dart';
import 'package:log_in/models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation, dropOffLocation;
  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}

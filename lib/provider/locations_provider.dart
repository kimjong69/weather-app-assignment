import 'package:flutter/material.dart';

class LocationsProvider extends ChangeNotifier {
  List<String> _locations = [];

  List<String> get locations => _locations;

  void addLocation(String location) {
    _locations.add(location.toLowerCase());
    notifyListeners();
  }

  void setLocations(List<String>? locations) {
    _locations = locations!;
    notifyListeners();
  }
}

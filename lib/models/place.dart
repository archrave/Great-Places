import 'dart:io'; //To access file object
import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });

  // ^ We don't REALLY require an address
}

class Place {
  final String title;
  final String id;
  final PlaceLocation location;
  final File image;

  Place({
    @required this.title,
    @required this.id,
    @required this.location,
    @required this.image,
  });
}

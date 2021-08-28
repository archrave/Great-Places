import 'package:flutter/cupertino.dart';

import 'package:flutter/widgets.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }
}

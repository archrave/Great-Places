import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    // This name of the following table should be the same everywhere
    print('Fetch function started...');
    final dataList = await DBHelper.getData('user_places');
    print('Fetch function after waiting');
    _places = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            // Creating a file from the path stored in the database
            image: File(item['image']),
            location: null,
          ),
        )
        .toList();
    notifyListeners();
  }
}

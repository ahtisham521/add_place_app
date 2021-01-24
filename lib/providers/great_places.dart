import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:textRecognizer/helpers/db_helper.dart';
import 'package:uuid/uuid.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image, PlaceLocation location) {
    Place _place = Place(
      id: Uuid().v4(),
      image: image,
      location: location,
      title: title,
    );

    _items.add(_place);

    notifyListeners();

    DBHelper.insert('user_places', {
      'id': _place.id,
      'title': _place.title,
      'image': _place.image.path,
      'loc_latitude': _place.location.latitude,
      'loc_longitude': _place.location.longitude,
      'loc_address': _place.location.address,
    });
  }

  void deletePlaceById(String id) {
    _items.removeWhere((element) => element.id == id);

    notifyListeners();

    DBHelper.deleteById('user_places', id);
  }

  Future<void> fetchAndSetPlaces() async {
    final queryResult = await DBHelper.getData('user_places');

    _items = queryResult
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            title: e['title'],
            location: PlaceLocation(
              latitude: e['loc_latitude'],
              longitude: e['loc_longitude'],
              address: e['loc_address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}

//   void addPlace(
//     String pickedTitle,
//     File pickedImage,
//   ) {
//     final newPlace = Place(
//       id: DateTime.now().toString(),
//       title: pickedTitle,
//       location: null,
//       image: pickedImage,
//     );
//     _items.add(newPlace);
//     notifyListeners();
//     DBHelper.insert('user_places', {
//       'id': newPlace.id,
//       'title': newPlace.title,
//       'image': newPlace.image.path,
//     });
//   }

//   Future<void> fetchAndSetPlaces() async {
//     final dataList = await DBHelper.getData('user_places');
//     _items = dataList
//         .map((item) => Place(
//               id: item['id'],
//               title: item['title'],
//               location: null,
//               image: File(item['image']),
//             ))
//         .toList();
//     notifyListeners();
//   }
// }

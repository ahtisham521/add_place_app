import 'dart:io';

import 'package:flutter/material.dart';
import '../models/place.dart';
import '../providers/great_places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File _savedImage;
  String _address;
  double _latitude;
  double _longitude;

  void _selectImage(File pickedImage) {
    _savedImage = pickedImage;
  }

  void _selectLocation(double latitude, double longitude, String address) {
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _savedImage == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _savedImage,
      PlaceLocation(
        latitude: _latitude,
        longitude: _longitude,
        address: _address,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ImageInput(_selectImage),
                  SizedBox(
                    height: 30,
                  ),
                  LocationInput(_selectLocation),
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:textRecognizer/providers/great_places.dart';
// import 'package:textRecognizer/widgets/location_input.dart';
// import '../widgets/image_input.dart';

// class AddPlaceScreen extends StatefulWidget {
//   static const routeName = '/add-place';
//   @override
//   _AddPlaceScreenState createState() => _AddPlaceScreenState();
// }

// class _AddPlaceScreenState extends State<AddPlaceScreen> {
//   final _titleController = TextEditingController();
//   File _pickedImage;

//   void _selectImage(File pickedImage) {
//     _pickedImage = pickedImage;
//   }

//   void _submitPlace() {
//     if (_titleController.text.isEmpty || _pickedImage == null) {
//       return;
//     }
//     Provider.of<GreatPlaces>(context, listen: false).addPlace(
//       _titleController.text,
//       _pickedImage,
//     );
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add a New Place',
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(labelText: 'Title'),
//                       controller: _titleController,
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     ImageInput(_selectImage),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     LocationInput(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           RaisedButton.icon(
//             onPressed: _submitPlace,
//             icon: Icon(Icons.add),
//             label: Text(
//               'Add Place',
//             ),
//             elevation: 0,
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             color: Theme.of(context).accentColor,
//           ),
//         ],
//       ),
//     );
//   }
// }

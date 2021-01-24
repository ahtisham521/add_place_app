import 'package:flutter/material.dart';
import '../helpers/location_helper.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function _selectLocation;

  const LocationInput(this._selectLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  String _locationAddress;

  Future<void> _getCurrentUserLocation() async {
    final LocationData location = await Location().getLocation();

    setState(() {
      _previewImageUrl = LocationHelper.generateLocationPreviewImageUrl(
          location.latitude, location.longitude);
      LocationHelper.getLocationAddress(location.latitude, location.longitude)
          .then(
        (address) => setState(() {
          _locationAddress = address;
          widget._selectLocation(
            location.latitude,
            location.longitude,
            address,
          );
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              border: Border.all(
            width: 1,
            color: Colors.grey,
          )),
          alignment: Alignment.center,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'No Location Selected',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        _locationAddress == null
            ? Container()
            : Text(
                _locationAddress,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Select Current Location'),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
          ],
        ),
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:textRecognizer/helpers/location_helper.dart';

// class LocationInput extends StatefulWidget {
//   @override
//   _LocationInputState createState() => _LocationInputState();
// }

// class _LocationInputState extends State<LocationInput> {
//   String _previewImageUrl;

//   Future<void> _getCurrentUserLocation() async {
//     final locData = await Location().getLocation();
//     final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
//       latitude: locData.latitude,
//       longitude: locData.longitude,
//     );
//     setState(() {
//       _previewImageUrl = staticMapImageUrl;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 170,
//           width: double.infinity,
//           decoration:
//               BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
//           child: _previewImageUrl == null
//               ? Center(
//                   child: Text(
//                     'no location chosen',
//                     textAlign: TextAlign.center,
//                   ),
//                 )
//               : Image.network(
//                   _previewImageUrl,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FlatButton.icon(
//               onPressed: _getCurrentUserLocation,
//               icon: Icon(Icons.location_on),
//               label: Text('Current Location'),
//             ),
//             FlatButton.icon(
//               onPressed: () {},
//               icon: Icon(Icons.map),
//               label: Text('Select On Map'),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../providers/great_places.dart';
import './add_places_screen.dart';
import './places_detail_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<GreatPlaces>(
              builder: (context, places, child) => places.items.length == 0
                  ? child
                  : ListView.builder(
                      itemCount: places.items.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                          child: ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(places.items[i].image,
                                    fit: BoxFit.cover),
                              ),
                            ),
                            title: Text(places.items[i].title),
                            subtitle: places.items[i].location.address == null
                                ? Text('')
                                : Text(places.items[i].location.address),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red[900],
                              ),
                              onPressed: () {
                                places.deletePlaceById(places.items[i].id);
                              },
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: places.items[i],
                              );
                            },
                          ),
                        );
                      },
                    ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(
                      'No place added yet. Add your favorite places now!',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10),
                  RaisedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('Add Place'),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
                    },
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/great_places.dart';
// import './add_places_screen.dart';

// class PlacesListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Places'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: () {
//               Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder(
//         future: Provider.of<GreatPlaces>(context, listen: false)
//             .fetchAndSetPlaces(),
//         builder: (context, snapshot) => snapshot.connectionState ==
//                 ConnectionState.waiting
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Consumer<GreatPlaces>(
//                 child: Center(
//                   child: Text(
//                     'Got no place yet, start adding some',
//                   ),
//                 ),
//                 builder: (context, greatPlaces, ch) =>
//                     greatPlaces.items.length <= 0
//                         ? ch
//                         : ListView.builder(
//                             itemCount: greatPlaces.items.length,
//                             itemBuilder: (ctx, index) => ListTile(
//                               leading: CircleAvatar(
//                                 backgroundImage:
//                                     FileImage(greatPlaces.items[index].image),
//                               ),
//                               title: Text(greatPlaces.items[index].title),
//                               onTap: () {},
//                             ),
//                           ),
//               ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../screens/add_place_screen.dart';

class PlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Great Places'),
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
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.grey,
                ),
              )
            : Consumer<GreatPlaces>(
                builder: (ctx, greatPlaces, ch) =>
                    greatPlaces.places.length <= 0
                        ? ch
                        : ListView.builder(
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.places[i].image),
                              ),
                              title: Text(greatPlaces.places[i].title),
                            ),
                            itemCount: greatPlaces.places.length,
                          ),
                child: Container(
                  child: Center(
                    child: Text('Hi guys, no great places available for now!'),
                  ),
                ),
              ),
      ),
    );
  }
}

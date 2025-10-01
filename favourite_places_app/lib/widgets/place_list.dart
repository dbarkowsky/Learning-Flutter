import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  final List<Place> places;
  const PlaceList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places stored.',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          for (final p in places)
            ListTile(
              title: Text(p.title),
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(p.image),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => PlaceDetails(place: p)),
                );
              },
            ),
        ],
      ),
    );
  }
}

import 'package:favourite_places_app/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;
  
  const PlaceDetails({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(place.title),),
      body: Center(child: Text(place.title),),
    );
  }
}

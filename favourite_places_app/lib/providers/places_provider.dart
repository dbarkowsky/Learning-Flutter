import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class PlacesProvider extends Notifier<List<Place>> {
  final List<Place> _places = [];

  @override
  List<Place> build() {
    return _places;
  }

  List<Place> getPlaces(){
    return _places;
  }

  void addPlace(Place p) async {
    // Save the image to the device
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(p.image.path);
    File imageFile = await p.image.copy('${appDir.path}/$fileName');

    Place placeWithLocalImage = Place(title: p.title, location: p.location, image: imageFile);
    _places.add(placeWithLocalImage);
  }

  void removePlace(Place p){
    _places.remove(p);
  }
}

final placesProvider = NotifierProvider(PlacesProvider.new);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places_app/models/place.dart';

class PlacesProvider extends Notifier<List<Place>> {
  final List<Place> _places = [];

  @override
  List<Place> build() {
    return _places;
  }

  List<Place> getPlaces(){
    return _places;
  }

  void addPlace(Place p){
    _places.add(p);
  }

  void removePlace(Place p){
    _places.remove(p);
  }
}

final placesProvider = NotifierProvider(PlacesProvider.new);

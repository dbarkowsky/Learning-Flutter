import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:favourite_places_app/models/place.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
// Need both for SQLite
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDB() async {
  // I don't love doing this here, but that's what the lesson does.
  final String dbPath = await sql.getDatabasesPath();
  // Create or open db
  final Database db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL)',
      );
    },
    version: 1,
  );
  return db;
}

class PlacesProvider extends Notifier<List<Place>> {
  List<Place> _places = [];

  @override
  List<Place> build() {
    return _places;
  }

  List<Place> getPlaces() {
    return _places;
  }

  void loadPlaces() async {
    Database db = await _getDB();
    final data = await db.query('places');
    // This type casting makes me unhappy.
    final places = data.map(
      (el) => Place(
        id: el['id'] as String,
        title: el['title'] as String,
        image: File(el['image'] as String),
        location: LatLng(el['lat'] as double, el['lng'] as double),
      ),
    ).toList();
    _places = places;
  }

  void addPlace(Place p) async {
    // Save the image to the device
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(p.image.path);
    // This seems to cause some issues in the emulator. :(
    File imageFile = await p.image.copy('${appDir.path}/$fileName');

    Place placeWithLocalImage = Place(
      title: p.title,
      location: p.location,
      image: imageFile,
    );

    Database db = await _getDB();
    // Store in db
    db.insert('places', {
      'id': placeWithLocalImage.id,
      'title': placeWithLocalImage.title,
      'image': placeWithLocalImage.image.path,
      'lat': placeWithLocalImage.location.latitude,
      'lng': placeWithLocalImage.location.longitude,
    });

    _places.add(placeWithLocalImage);
  }

  void removePlace(Place p) {
    _places.remove(p);
  }
}

final placesProvider = NotifierProvider(PlacesProvider.new);

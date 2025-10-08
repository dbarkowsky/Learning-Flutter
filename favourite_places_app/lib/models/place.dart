import 'dart:io';

import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  final String id;
  final String title;
  final File image;
  final LatLng location;

  Place({required this.title, required this.image, required this.location, String? id})
    : id = id ?? uuid.v4();
}

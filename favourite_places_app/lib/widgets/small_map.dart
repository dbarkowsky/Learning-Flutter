import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class SmallMap extends StatefulWidget {
  final MapController controller;
  SmallMap({super.key, required this.controller});

  @override
  State<SmallMap> createState() => _SmallMapState();
}

class _SmallMapState extends State<SmallMap> {
  TileLayer? mapTiles;

  FlutterMap? map;

  @override
  void initState() {
    super.initState();
    mapTiles = TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: "dbarkowsky/Learning-Flutter",
    );
    map = FlutterMap(
      mapController: widget.controller,
      options: MapOptions(),
      children: [mapTiles!],
    );
  }

  void setLocation(LatLng location) {
    print(location);
  }

  @override
  Widget build(BuildContext context) {
    return map!;
  }
}

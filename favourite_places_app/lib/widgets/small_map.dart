import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class SmallMap extends StatefulWidget {
  final MapController controller;
  final List<Marker> markers;
  const SmallMap({
    super.key,
    required this.controller,
    this.markers = const [],
  });

  @override
  State<SmallMap> createState() => _SmallMapState();
}

class _SmallMapState extends State<SmallMap> {
  TileLayer? mapTiles;
  FlutterMap? map;

  @override
  void initState() {
    super.initState();
    print(widget.markers);

    mapTiles = TileLayer(
      urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      userAgentPackageName: "dbarkowsky/Learning-Flutter",
    );
    map = FlutterMap(
      mapController: widget.controller,
      options: MapOptions(),
      children: [
        mapTiles!,
        MarkerLayer(markers: widget.markers),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return map!;
  }
}

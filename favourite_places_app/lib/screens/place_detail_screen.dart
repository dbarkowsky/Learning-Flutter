import 'package:favourite_places_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;

  const PlaceDetails({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    MapController controller = MapController();
    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CircleAvatar(
              radius: 100,
              // This is generally a bad use of the map. It's reloading the tiles each time.
              // These should be cached instead. Or we just show a still image of the location.
              child: FlutterMap(
                mapController: controller,
                options: MapOptions(
                  onMapReady: (){
                    controller.move(place.location, 10);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "dbarkowsky/Learning-Flutter",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:favourite_places_app/widgets/small_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  bool _isGettingLocation = false;
  LocationData? _locationData;
  MapController? _mapController;
  SmallMap? _map;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _map = SmallMap(controller: _mapController!);
  }

  _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });
    Location location = Location();

    // Some template code to check if we have location permissions/access
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Request current location
    _locationData = await location.getLocation();

    setState(() {
      if (_locationData != null && _mapController != null) {
        _mapController!.move(LatLng(_locationData!.latitude!, _locationData!.longitude!), 18);
      }
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget childContent = Text(
      "No location chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );

    if (_isGettingLocation) {
      childContent = CircularProgressIndicator();
    }

    if (_locationData != null && _map != null){
      childContent = _map!;
    }

    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: childContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: Text("Use Current Location"),
              icon: Icon(Icons.location_on),
            ),
            TextButton.icon(
              onPressed: () {},
              label: Text("Select on Map"),
              icon: Icon(Icons.map),
            ),
          ],
        ),
      ],
    );
  }
}

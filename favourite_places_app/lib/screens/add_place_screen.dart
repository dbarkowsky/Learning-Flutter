import 'dart:io';

import 'package:favourite_places_app/models/place.dart';
import 'package:favourite_places_app/providers/places_provider.dart';
import 'package:favourite_places_app/widgets/image_input.dart';
import 'package:favourite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? image;
  LatLng? location;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || image == null || location == null) {
      return;
    }
    ref
        .read(placesProvider.notifier)
        .addPlace(Place(title: enteredTitle, image: image!, location: location!));
    Navigator.of(context).pop();
  }

  void _setImage(File f) {
    setState(() {
      image = f;
    });
  }

  void _setLocation(LatLng ll){
    setState(() {
      location = ll;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a place')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            const SizedBox(height: 10),
            ImageInput(onChooseImage: _setImage),
            const SizedBox(height: 10),
            LocationInput(onChooseLocation: _setLocation,),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              label: const Text('Save'),
              icon: Icon(Icons.save),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapLocationPicker extends StatefulWidget {
  @override
  _MapLocationPickerState createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  late GoogleMapController _mapController;
  LatLng _selectedLocation = const LatLng(37.7749, -122.4194); // Default: San Francisco
  String _address = "Enter address or move the marker";
  final DraggableScrollableController _sheetController = DraggableScrollableController();
  final TextEditingController _textController = TextEditingController();

  void _expandBottomSheet() {
    _sheetController.animateTo(
      1.0, // Fully open (1.0 = full screen height)
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get user’s current location
  }

  // 📌 Get User's Current Location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _selectedLocation = LatLng(position.latitude, position.longitude);
    });

    _updateAddress(_selectedLocation);
    _mapController.animateCamera(CameraUpdate.newLatLng(_selectedLocation));
  }

  // 📌 Reverse Geocoding (LatLng → Address)
  Future<void> _updateAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address = "${place.street}, ${place.locality}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Failed to get address";
      });
    }
  }

  // 📌 Geocoding (Address → LatLng)
  Future<void> _updateLocationFromAddress() async {
    try {
      List<Location> locations = await locationFromAddress(_address);
      if (locations.isNotEmpty) {
        LatLng newPosition = LatLng(locations.first.latitude, locations.first.longitude);
        setState(() {
          _selectedLocation = newPosition;
        });
        _mapController.animateCamera(CameraUpdate.newLatLng(newPosition));
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 📌 Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: {
              Marker(
                markerId: const MarkerId("selected_location"),
                position: _selectedLocation,
                draggable: true,
                onDragEnd: (newPosition) {
                  setState(() {
                    _selectedLocation = newPosition;
                  });
                  _updateAddress(newPosition);
                },
              ),
            },
            onTap: (newPosition) {
              setState(() {
                _selectedLocation = newPosition;
              });
              _updateAddress(newPosition);
            },
          ),

          // 📌 Permanent Bottom Sheet
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: 0.3, // 30% of screen height
            minChildSize: 0.3,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Enter Address",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: _updateLocationFromAddress,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _address = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_pin, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _address,
                            style: const TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, _selectedLocation);
                      },
                      child: const Text("Confirm Location"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

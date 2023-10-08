import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({
    required this.onMapCreated,
    required this.currentUserLocation,
    super.key,
  });

  final void Function(GoogleMapController) onMapCreated;
  final LatLng currentUserLocation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: currentUserLocation,
          zoom: 16,
        ),
        onMapCreated: onMapCreated,
        markers: {
          Marker(
            markerId: const MarkerId('current_location'),
            position: currentUserLocation,
            onTap: () {},
          ),
        },
      ),
    );
  }
}

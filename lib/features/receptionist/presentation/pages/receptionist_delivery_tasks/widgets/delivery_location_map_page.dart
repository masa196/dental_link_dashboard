import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DeliveryLocationMapPage extends StatelessWidget {
  const DeliveryLocationMapPage({
    super.key,
    required this.latitude,
    required this.longitude,
    this.locationName,
  });

  final double latitude;
  final double longitude;
  final String? locationName;

  @override
  Widget build(BuildContext context) {
    final position = LatLng(latitude, longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text('موقع الطبيب'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: position,
          initialZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.dental_link.dashboard',
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: position,
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.location_on,
                  size: 50,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:dental_link_dashboard/features/admin/data/models/location/location_model.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/location/location_cubit.dart';
import 'package:dental_link_dashboard/features/admin/presentation/cubit/location/location_state.dart';

class MapPickerPage extends StatefulWidget {
  const MapPickerPage({super.key});

  @override
  State<MapPickerPage> createState() => _MapPickerPageState();
}

class _MapPickerPageState extends State<MapPickerPage> {
  LatLng? selectedPoint;

  @override
  void initState() {
    super.initState();

    context.read<LocationCubit>().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اختر الموقع"),
      ),

      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {},

        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LocationError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is LocationLoaded) {
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: state.selectedLocation,
                    initialZoom: 15,

                    onTap: (_, point) async {
                      selectedPoint = point;

                      await context
                          .read<LocationCubit>()
                          .selectLocation(point);
                    },
                  ),

                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),

                    MarkerLayer(
                      markers: [
                        Marker(
                          point: state.selectedLocation,
                          width: 50,
                          height: 50,

                          child: const Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,

                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.locationName,
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,

                            child: FilledButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  LocationModel(
                                    name: state.locationName,
                                    lat: state.selectedLocation.latitude,
                                    lng: state.selectedLocation.longitude,
                                  ),
                                );
                              },

                              child: const Text("تأكيد الموقع"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
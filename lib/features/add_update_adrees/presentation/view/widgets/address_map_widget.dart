import 'package:flower_app/core/widgets/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/add_update_adrees/domain/models/location_entity.dart';

class AddressMapWidget extends StatelessWidget {
  final MapController mapController;
  final LocationEntity? selectedLocation;
  final ValueChanged<LatLng> onMapTap;
  final VoidCallback onGetCurrentLocation;
  final bool isLoading;

  const AddressMapWidget({
    super.key,
    required this.mapController,
    required this.selectedLocation,
    required this.onMapTap,
    required this.onGetCurrentLocation,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    const LatLng defaultLocation = LatLng(30.0444, 31.2357);

    return SizedBox(
      height: height * 0.45,
      child: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: selectedLocation != null
                  ? LatLng(
                      selectedLocation!.latitude,
                      selectedLocation!.longitude,
                    )
                  : defaultLocation,
              initialZoom: 13.0,
              onTap: (tapPosition, latLng) {
                onMapTap(latLng);
              },
            ),
            children: [
              // OpenStreetMap tiles
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flower_app',
              ),

              // Location marker
              if (selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(
                        selectedLocation!.latitude,
                        selectedLocation!.longitude,
                      ),
                      width: 80,
                      height: 80,
                      child: const Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // Loading overlay
          if (isLoading)
            Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              child: const Center(child: LoadingIndicator()),
            ),

          // Current location button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: AppColors.primary,
              onPressed: onGetCurrentLocation,
              child: const Icon(Icons.my_location, color: AppColors.background),
            ),
          ),
        ],
      ),
    );
  }
}

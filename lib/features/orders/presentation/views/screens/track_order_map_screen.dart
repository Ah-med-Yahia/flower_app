import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_app/core/constants/app_text_constants.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/features/orders/data/models/track_order_model.dart';
import 'package:flower_app/features/orders/presentation/views/widgets/driver_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

class TrackOrderMapScreen extends StatefulWidget {
  final String userId;
  final String orderId;

  const TrackOrderMapScreen({
    super.key,
    required this.userId,
    required this.orderId,
  });

  @override
  State<TrackOrderMapScreen> createState() => _TrackOrderMapScreenState();
}

class _TrackOrderMapScreenState extends State<TrackOrderMapScreen> {
  static const _defaultUserId = '69deac8e6bbaf1588bbc1984';
  static const _defaultOrderId = '69e182da6bbaf1588bbc86c9';
  final MapController _mapController = MapController();

  LatLng _getStoreLatLng(TrackOrderModel order) {
    double lat = 30.0131;
    double lng = 31.2089;
    if (order.store?.latLong != null && order.store!.latLong.isNotEmpty) {
      final parts = order.store!.latLong.split(',');
      if (parts.length == 2) {
        lat = double.tryParse(parts[0].trim()) ?? lat;
        lng = double.tryParse(parts[1].trim()) ?? lng;
      }
    }
    return LatLng(lat, lng);
  }

  LatLng _getUserLatLng(TrackOrderModel order) {
    if (order.user?.location != null) {
      return LatLng(
        order.user!.location!.latitude,
        order.user!.location!.longitude,
      );
    }
    // Default fallback slightly offset from store
    final store = _getStoreLatLng(order);
    return LatLng(store.latitude - 0.005, store.longitude - 0.005);
  }

  LatLng _getDriverLatLng(TrackOrderModel order) {
    if (order.driver?.location != null) {
      return LatLng(
        order.driver!.location!.latitude,
        order.driver!.location!.longitude,
      );
    }
    // Default fallback somewhere in between
    final store = _getStoreLatLng(order);
    final user = _getUserLatLng(order);
    return LatLng(
      (store.latitude + user.latitude) / 2,
      (store.longitude + user.longitude) / 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final path =
        'users/${widget.userId.isEmpty ? _defaultUserId : widget.userId}/orders/${widget.orderId.isEmpty ? _defaultOrderId : widget.orderId}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.doc(path).snapshots(),
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (orderSnapshot.hasError ||
              !orderSnapshot.hasData ||
              !orderSnapshot.data!.exists) {
            return const Center(child: Text('Order not found'));
          }

          final data = orderSnapshot.data!.data() as Map<String, dynamic>;
          final order = TrackOrderModel.fromMap(data);

          final storeLoc = _getStoreLatLng(order);
          final userLoc = _getUserLatLng(order);
          final driverLoc = _getDriverLatLng(order);

          DateTime baseTime;
          try {
            baseTime = DateTime.parse(order.createdAt.replaceAll(' ', 'T'));
          } catch (_) {
            baseTime = DateTime.now();
          }

          final estimatedArrival = baseTime.add(const Duration(hours: 4));
          final arrivalStr = DateFormat(
            'dd MMM yyyy, hh:mm a',
          ).format(estimatedArrival);
          final driver = order.driver;

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(
                    (storeLoc.latitude + userLoc.latitude) / 2,
                    (storeLoc.longitude + userLoc.longitude) / 2,
                  ),
                  initialZoom: 13.5,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.flower_app',
                  ),
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [storeLoc, driverLoc, userLoc],
                        color: AppColors.primary,
                        strokeWidth: 3.0,
                        pattern: StrokePattern.dashed(segments: const [10, 10]),
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: storeLoc,
                        width: 100,
                        height: 40,
                        alignment: Alignment.topCenter,
                        child: _buildLocationPin(
                          AppTextConstants.flowery,
                          Icons.local_florist,
                          AppColors.primary,
                        ),
                      ),
                      Marker(
                        point: userLoc,
                        width: 100,
                        height: 40,
                        alignment: Alignment.topCenter,
                        child: _buildLocationPin(
                          'Apartment',
                          Icons.home,
                          AppColors.primary,
                        ),
                      ),
                      Marker(
                        point: driverLoc,
                        width: 60,
                        height: 60,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.asset(
                              'assets/images/Car.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTextConstants.trackOrderEstimatedArrival,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 13,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              arrivalStr,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            if (driver != null)
                              DriverInfoCard(
                                name: driver.fullName,
                                photoUrl: driver.photo,
                                phone: driver.phone,
                              )
                            else
                              DriverInfoCard(
                                name: AppTextConstants
                                    .trackOrderDefaultDriverName,
                                photoUrl:
                                    'https://flower.elevateegy.com/uploads/default-profile.png',
                                phone: '+201091391966',
                              ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                      ),
                                ),
                                child: const Text(
                                  'Order details',
                                ), // Can use AppTextConstants.cartDescription or add string
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLocationPin(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

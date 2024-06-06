import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  final LatLng _defaultCenter = const LatLng(45.521563, -122.677433);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  final String styleId = const String.fromEnvironment('MAPBOX_STYLE_ID');
  final String username = const String.fromEnvironment('MAPBOX_USERNAME');
  final String mapboxAccessToken =
      const String.fromEnvironment('MAPBOX_ACCESS_TOKEN');
  late Future<LatLng> _locationFuture;
  bool _isRequestingPermission = false; // Track permission request state

  @override
  void initState() {
    super.initState();
    _locationFuture = _getLocation(); // Initialize the future
  }

  Future<LatLng> _getLocation() async {
    if (_isRequestingPermission) return widget._defaultCenter;

    setState(() {
      _isRequestingPermission = true;
    });

    try {
      PermissionStatus permissionStatus = await Permission.location.status;

      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.location.request();
      }

      if (permissionStatus.isGranted) {
        final Position coordinates = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        return LatLng(coordinates.latitude, coordinates.longitude);
      }

      return widget._defaultCenter;
    } finally {
      setState(() {
        _isRequestingPermission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: _locationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: snapshot.data!,
                  initialZoom: 15.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/$username/$styleId/tiles/512/{z}/{x}/{y}@2x?access_token=$mapboxAccessToken',
                    userAgentPackageName: 'com.example.flare',
                  ),
                  CurrentLocationLayer(
                    alignPositionOnUpdate: AlignOnUpdate.never,
                    alignDirectionOnUpdate: AlignOnUpdate.never,
                    style: const LocationMarkerStyle(
                      marker: DefaultLocationMarker(
                        child: Icon(
                          Icons.navigation,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                      markerSize: Size(20, 20),
                      showHeadingSector: false,
                      markerDirection: MarkerDirection.heading,
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return const Center(child: Text('Location not available'));
        }
      },
    );
  }
}

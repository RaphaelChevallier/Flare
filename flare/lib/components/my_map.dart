// my_map.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radar/flutter_radar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

final Completer<GoogleMapController> _controller = Completer();

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  final LatLng _defaultCenter = const LatLng(45.521563, -122.677433);

  Future<LatLng> getLocation() async {
    final permissionStatus = await Permission.location.status;

    if (permissionStatus.isGranted) {
      final coordinates = await Radar.getLocation();
      if (coordinates != null &&
          coordinates['location']['latitude'] != null &&
          coordinates['location']['longitude'] != null) {
        return LatLng(coordinates['location']['latitude'],
            coordinates['location']['longitude']);
      } else {
        return _defaultCenter; // Default location if coordinates are null or invalid
      }
    } else if (permissionStatus.isDenied ||
        permissionStatus.isPermanentlyDenied ||
        permissionStatus.isRestricted ||
        permissionStatus.isLimited) {
      final newStatus = await Permission.location.request();
      if (newStatus.isGranted) {
        final coordinates = await Radar.getLocation();
        if (coordinates != null &&
            coordinates['location']['latitude'] != null &&
            coordinates['location']['longitude'] != null) {
          return LatLng(coordinates['location']['latitude'],
              coordinates['location']['longitude']);
        } else {
          return _defaultCenter; // Default location if coordinates are null or invalid
        }
      } else {
        return _defaultCenter; // Default location if permission is not granted
      }
    }

    return _defaultCenter; // Default location if permission is not granted
  }

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late String _mapStyleString;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_styles.json').then((string) {
      setState(() {
        _mapStyleString = string;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LatLng>(
      future: widget.getLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
              target: snapshot.data!,
              zoom: 15.0,
            ),
            style: _mapStyleString,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          );
        } else {
          return const Center(child: Text('Location not available'));
        }
      },
    );
  }
}

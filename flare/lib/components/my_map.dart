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

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late String _mapStyleString;
  late Future<LatLng> _locationFuture;
  bool _isRequestingPermission = false; // Track permission request state

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_styles.json').then((string) {
      setState(() {
        _mapStyleString = string;
      });
    });
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
        final coordinates = await Radar.getLocation();
        if (coordinates != null &&
            coordinates['location']['latitude'] != null &&
            coordinates['location']['longitude'] != null) {
          return LatLng(coordinates['location']['latitude'],
              coordinates['location']['longitude']);
        }
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

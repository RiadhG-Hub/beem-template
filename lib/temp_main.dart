import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      ),
      home: const RideBookingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RideBookingPage extends StatefulWidget {
  const RideBookingPage({Key? key}) : super(key: key);

  @override
  State<RideBookingPage> createState() => _RideBookingPageState();
}

class _RideBookingPageState extends State<RideBookingPage> {
  final DraggableScrollableController _scrollController =
      DraggableScrollableController();
  GoogleMapController? _mapController;

  // Tunis, Tunisia coordinates (based on user location)
  static const LatLng _center = LatLng(36.8065, 10.1815);

  // Sample locations in Tunis
  static const LatLng _pickupLocation =
      LatLng(36.8085, 10.1835); // camelsoft LLC area
  static const LatLng _destinationLocation =
      LatLng(36.7980, 10.1650); // Mall area

  // Taxi route points for realistic movement
  final List<LatLng> _taxiRoute = [
    LatLng(36.8075, 10.1825), // Starting position
    LatLng(36.8070, 10.1820),
    LatLng(36.8065, 10.1815),
    LatLng(36.8060, 10.1810),
    LatLng(36.8055, 10.1805),
    LatLng(36.8050, 10.1800),
    LatLng(36.8045, 10.1795),
    LatLng(36.8040, 10.1790),
    LatLng(36.8035, 10.1785),
    LatLng(36.8030, 10.1780),
    LatLng(36.8025, 10.1775),
    LatLng(36.8020, 10.1770),
    LatLng(36.8015, 10.1765),
    LatLng(36.8010, 10.1760),
    LatLng(36.8005, 10.1755),
    LatLng(36.8000, 10.1750),
    LatLng(36.7995, 10.1745),
    LatLng(36.7990, 10.1740),
    LatLng(36.7985, 10.1735),
    LatLng(36.7980, 10.1730),
    LatLng(36.7975, 10.1725),
    LatLng(36.7970, 10.1720),
    LatLng(36.7965, 10.1715),
    LatLng(36.7960, 10.1710),
    LatLng(36.7955, 10.1705),
    LatLng(36.7950, 10.1700),
    LatLng(36.7945, 10.1695),
    LatLng(36.7940, 10.1690),
    LatLng(36.7935, 10.1685),
    LatLng(36.7930, 10.1680),
    LatLng(36.7925, 10.1675),
    LatLng(36.7920, 10.1670),
    LatLng(36.7915, 10.1665),
    LatLng(36.7910, 10.1660),
    LatLng(36.7905, 10.1655),
    LatLng(36.7900, 10.1650),
    LatLng(36.7895, 10.1645),
    LatLng(36.7890, 10.1640),
    LatLng(36.7885, 10.1635),
    LatLng(36.7880, 10.1630),
    LatLng(36.7875, 10.1625),
    LatLng(36.7870, 10.1620),
    LatLng(36.7860, 10.1617),
    LatLng(36.7865, 10.1615),
    LatLng(36.7860, 10.1610),
    const LatLng(36.7980, 10.1650), // Destination
  ];

  int _currentTaxiIndex = 0;
  Timer? _taxiMovementTimer;
  double _taxiBearing = 0.0;
  bool _isTaxiMoving = false;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _createMarkersAndRoute();
    _startTaxiMovement();
  }

  @override
  void dispose() {
    _taxiMovementTimer?.cancel();
    super.dispose();
  }

  void _createMarkersAndRoute() {
    // Create markers for pickup and destination
    _markers = {
      Marker(
        markerId: const MarkerId('pickup'),
        position: _pickupLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: const InfoWindow(
          title: 'Pickup Location',
          snippet: 'camelsoft LLC',
        ),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: _destinationLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(
          title: 'Destination',
          snippet: 'Mall Of Sousse',
        ),
      ),
    };

    // Create the main route polyline
    _polylines = {
      Polyline(
        polylineId: const PolylineId("main_route"),
        points: [
          _pickupLocation,
          LatLng(36.8060, 10.1800),
          LatLng(36.8020, 10.1750),
          LatLng(36.8000, 10.1700),
          _destinationLocation,
        ],
        color: const Color(0xFF4CAF50),
        width: 4,
        patterns: [PatternItem.dash(20), PatternItem.gap(10)],
      ),
      // Taxi route polyline (more detailed)
      Polyline(
        polylineId: const PolylineId("taxi_route"),
        points: _taxiRoute,
        color: const Color(0xFF2196F3),
        width: 3,
        patterns: [PatternItem.dot, PatternItem.gap(10)],
      ),
    };

    _updateTaxiMarker();
  }

  Future<void> _updateTaxiMarker() async {
    if (_currentTaxiIndex < _taxiRoute.length) {
      // Calculate bearing for taxi direction
      if (_currentTaxiIndex < _taxiRoute.length - 1) {
        _taxiBearing = _calculateBearing(
          _taxiRoute[_currentTaxiIndex],
          _taxiRoute[_currentTaxiIndex + 1],
        );
      }

      // Update taxi marker
      final taxiMarker = Marker(
        markerId: const MarkerId('taxi'),
        position: _taxiRoute[_currentTaxiIndex],
        icon: await BitmapDescriptor.asset(
            const ImageConfiguration(size: Size(50, 50)),
            "assets/images/taxi.png"),
        rotation: _taxiBearing,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          title: 'Ben Stokes',
          snippet:
              'En route - 4.9★ ${(_currentTaxiIndex / _taxiRoute.length * 100).toInt()}% complete',
        ),
      );

      setState(() {
        _markers.removeWhere((marker) => marker.markerId.value == 'taxi');
        _markers.add(taxiMarker);
      });
    }
  }

  double _calculateBearing(LatLng start, LatLng end) {
    double startLat = start.latitude * (math.pi / 180);
    double startLng = start.longitude * (math.pi / 180);
    double endLat = end.latitude * (math.pi / 180);
    double endLng = end.longitude * (math.pi / 180);

    double dLng = endLng - startLng;

    double y = math.sin(dLng) * math.cos(endLat);
    double x = math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(dLng);

    double bearing = math.atan2(y, x);
    return (bearing * (180 / math.pi) + 360) % 360;
  }

  void _startTaxiMovement() {
    _taxiMovementTimer =
        Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_currentTaxiIndex < _taxiRoute.length - 1) {
        _currentTaxiIndex++;
        _updateTaxiMarker();
      } else {
        // Reset taxi position for continuous movement
        _currentTaxiIndex = 0;
        _updateTaxiMarker();
      }
    });
  }

  void _toggleTaxiMovement() {
    setState(() {
      _isTaxiMoving = !_isTaxiMoving;
    });

    if (_isTaxiMoving) {
      _startTaxiMovement();
    } else {
      _taxiMovementTimer?.cancel();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _setMapStyle();
  }

  void _setMapStyle() async {
    String style = '''
    [
      {
        "featureType": "water",
        "stylers": [
          {
            "color": "#19a0d8"
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "labels.text.stroke",
        "stylers": [
          {
            "color": "#ffffff"
          },
          {
            "weight": 6
          }
        ]
      },
      {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
          {
            "color": "#e85113"
          }
        ]
      }
    ]
    ''';
    _mapController?.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Maps
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            trafficEnabled: true,
            buildingsEnabled: true,
            onTap: (LatLng location) {
              print('Tapped at: ${location.latitude}, ${location.longitude}');
            },
          ),

          // Status bar with green background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).padding.top + 44,
              decoration: const BoxDecoration(
                color: Color(0xFF4CAF50),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '9:41',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          // Signal bars
                          Row(
                            children: List.generate(
                                4,
                                (index) => Container(
                                      width: 3,
                                      height: (4 + (index * 2)).toDouble(),
                                      margin: const EdgeInsets.only(right: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                    )),
                          ),
                          const SizedBox(width: 5),
                          // WiFi icon
                          const Icon(Icons.wifi, color: Colors.white, size: 18),
                          const SizedBox(width: 5),
                          // Battery
                          Container(
                            width: 25,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Map controls
          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoom_in",
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomIn());
                  },
                  child: const Icon(Icons.add, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoom_out",
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _mapController?.animateCamera(CameraUpdate.zoomOut());
                  },
                  child: const Icon(Icons.remove, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "my_location",
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _mapController?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(target: _center, zoom: 13.0),
                      ),
                    );
                  },
                  child: const Icon(Icons.my_location, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                // Taxi movement control
                FloatingActionButton(
                  heroTag: "taxi_control",
                  mini: true,
                  backgroundColor: _isTaxiMoving ? Colors.red : Colors.green,
                  onPressed: _toggleTaxiMovement,
                  child: Icon(
                    _isTaxiMoving ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Draggable scrollable sheet for ride requests
          DraggableScrollableSheet(
            controller: _scrollController,
            initialChildSize: 0.45,
            minChildSize: 0.3,
            maxChildSize: 0.85,
            snap: true,
            snapSizes: const [0.3, 0.45, 0.85],
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // Handle indicator
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(top: 10, bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    // First ride request card
                    RideRequestCard(
                      driverName: 'Ben Stokes',
                      rating: 4.9,
                      price: '15 TND',
                      duration: '20 min',
                      pickupLocation: 'camelsoft LLC',
                      destination: 'Mall Of Sousse',
                      distance: '6 Km',
                      isActive: true,
                      onAccept: () {
                        _showRouteOnMap();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Ride request accepted!')),
                        );
                      },
                      onDecline: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Ride request declined')),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Second ride request card
                    RideRequestCard(
                      driverName: 'Ahmed Hassan',
                      rating: 4.7,
                      price: '18 TND',
                      duration: '25 min',
                      pickupLocation: 'Al Wadi Compound',
                      destination: 'Tunis Airport',
                      distance: '8 Km',
                      onAccept: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Second ride accepted!')),
                        );
                      },
                      onDecline: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Second ride declined')),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Third ride request card
                    RideRequestCard(
                      driverName: 'Sara Mansouri',
                      rating: 4.8,
                      price: '12 TND',
                      duration: '15 min',
                      pickupLocation: 'Al Duha District',
                      destination: 'Tunis Marina',
                      distance: '4 Km',
                      onAccept: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Third ride accepted!')),
                        );
                      },
                      onDecline: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Third ride declined')),
                        );
                      },
                    ),

                    const SizedBox(height: 100), // Bottom padding
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showRouteOnMap() {
    // Animate to show the route
    _mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(
            _destinationLocation.latitude - 0.01,
            _destinationLocation.longitude - 0.01,
          ),
          northeast: LatLng(
            _pickupLocation.latitude + 0.01,
            _pickupLocation.longitude + 0.01,
          ),
        ),
        100.0, // padding
      ),
    );
  }
}

class RideRequestCard extends StatelessWidget {
  final String driverName;
  final double rating;
  final String price;
  final String duration;
  final String pickupLocation;
  final String destination;
  final String distance;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final bool isActive;

  const RideRequestCard({
    Key? key,
    required this.driverName,
    required this.rating,
    required this.price,
    required this.duration,
    required this.pickupLocation,
    required this.destination,
    required this.distance,
    required this.onAccept,
    required this.onDecline,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isActive
            ? Border.all(color: const Color(0xFF4CAF50), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Active indicator
          if (isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'EN ROUTE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          if (isActive) const SizedBox(height: 16),

          // Driver info and price row
          Row(
            children: [
              // Driver avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4A4A4A),
                      Color(0xFF2C2C2C),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    driverName.split(' ').map((name) => name[0]).join(''),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              // Driver name and rating
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driverName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFB800),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF757575),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Price and duration column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Route visualization
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Route line and dots
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8E44AD),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 2,
                        color: const Color(0xFFE0E0E0),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53E3E),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 16),

                // Location texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          pickupLocation,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1A1A1A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          destination,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1A1A1A),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Distance indicator
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5722),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.directions_car,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                distance,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              // Decline button
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB19CD9),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFB19CD9).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: onDecline,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Accept button
              Expanded(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7B2CBF),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7B2CBF).withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: onAccept,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: Color(0xFF1C1C1E),
        primarySwatch: MaterialColor(0xFF8BC34A, {
          50: Color(0xFFF1F8E9),
          100: Color(0xFFDCEDC8),
          200: Color(0xFFC5E1A5),
          300: Color(0xFFAED581),
          400: Color(0xFF9CCC65),
          500: Color(0xFF8BC34A),
          600: Color(0xFF7CB342),
          700: Color(0xFF689F38),
          800: Color(0xFF558B2F),
          900: Color(0xFF33691E),
        }),
      ),
      home: RideRequestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RideRequestScreen extends StatefulWidget {
  @override
  _RideRequestScreenState createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  bool autoAcceptNearest = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
        leading: Icon(Icons.arrow_upward, color: Colors.white),
        title: Text(
          'Head north',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: [
          Icon(Icons.settings, color: Colors.white),
          SizedBox(width: 8),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Status bar info

          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                // First ride request
                RideRequestCard(
                  requestId: 'TND15',
                  driverName: 'Boughannni',
                  rating: 5.0,
                  totalRides: 726,
                  carModel: 'Peugeot 301',
                  duration: '10 min.',
                  distance: '3.1 km',
                  profileImage: 'assets/driver1.jpg',
                ),

                SizedBox(height: 16),

                // Second ride request
                RideRequestCard(
                  requestId: 'TND18',
                  driverName: 'ISMAIL',
                  rating: 4.93,
                  totalRides: 160,
                  carModel: 'Peugeot 208',
                  duration: '20 min.',
                  distance: '8.2 km',
                  profileImage: 'assets/driver2.jpg',
                ),

                SizedBox(height: 16),

                // Third ride request
                RideRequestCard(
                  requestId: 'TND18',
                  driverName: null,
                  rating: null,
                  totalRides: null,
                  carModel: null,
                  duration: null,
                  distance: null,
                  profileImage: null,
                ),

                SizedBox(height: 24),

                // Driver count info
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '11 drivers viewed your request',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      SizedBox(width: 12),
                      // Driver avatars
                      Container(
                        width: 140,
                        height: 32,
                        child: Stack(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Positioned(
                                left: i * 20.0,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.grey[600],
                                  child: Icon(Icons.person,
                                      color: Colors.white, size: 16),
                                ),
                              ),
                            Positioned(
                              left: 5 * 20.0,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.grey[700],
                                child: Text(
                                  '+6',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Auto accept toggle
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.near_me, color: Colors.white, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Automatically accept the nearest',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              'driver for TND15',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: autoAcceptNearest,
                        onChanged: (value) {
                          setState(() {
                            autoAcceptNearest = value;
                          });
                        },
                        activeColor: Color(0xFF8BC34A),
                        inactiveThumbColor: Colors.grey[400],
                        inactiveTrackColor: Colors.grey[700],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Cancel button
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel request',
                      style: TextStyle(
                        color: Colors.red[400],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom navigation
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),

          // Navigation buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RideRequestCard extends StatelessWidget {
  final String requestId;
  final String? driverName;
  final double? rating;
  final int? totalRides;
  final String? carModel;
  final String? duration;
  final String? distance;
  final String? profileImage;

  const RideRequestCard({
    Key? key,
    required this.requestId,
    this.driverName,
    this.rating,
    this.totalRides,
    this.carModel,
    this.duration,
    this.distance,
    this.profileImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Request ID
          Text(
            requestId,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 16),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Decline',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8BC34A),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),

          if (driverName != null) ...[
            SizedBox(height: 16),

            // Driver info
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[600],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            driverName!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text(
                            '${rating}',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(width: 4),
                          Text(
                            '($totalRides rides)',
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        carModel!,
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      duration!,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      distance!,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

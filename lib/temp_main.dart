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
        scaffoldBackgroundColor: const Color(0xFF1C1C1E),
      ),
      home: RideBookingPage(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background with custom painting
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFF5F5F5),
            child: CustomPaint(
              painter: MapPainter(),
              size: Size.infinite,
            ),
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

          // Taxi icon positioned on the map
          const Positioned(
            top: 320,
            left: 150,
            child: TaxiIcon(),
          ),

          // Green area on map
          Positioned(
            top: 380,
            left: 280,
            child: Container(
              width: 50,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFF81C784),
                borderRadius: BorderRadius.circular(4),
              ),
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
                      onAccept: () {
                        print('First ride accepted');
                      },
                      onDecline: () {
                        print('First ride declined');
                      },
                    ),

                    const SizedBox(height: 20),

                    // Second ride request card
                    RideRequestCard(
                      driverName: 'Ben Stokes',
                      rating: 4.9,
                      price: '15 TND',
                      duration: '20 min',
                      pickupLocation: 'camelsoft LLC',
                      destination: 'Mall Of Sousse',
                      distance: '6 Km',
                      onAccept: () {
                        print('Second ride accepted');
                      },
                      onDecline: () {
                        print('Second ride declined');
                      },
                    ),

                    const SizedBox(height: 20),

                    // Additional ride requests for scrolling demo
                    RideRequestCard(
                      driverName: 'Ahmed Hassan',
                      rating: 4.7,
                      price: '18 TND',
                      duration: '25 min',
                      pickupLocation: 'Downtown Center',
                      destination: 'Airport Terminal',
                      distance: '8 Km',
                      onAccept: () {
                        print('Third ride accepted');
                      },
                      onDecline: () {
                        print('Third ride declined');
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Driver info and price row
          Row(
            children: [
              // Driver avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF4A4A4A),
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
                        color: Color(0xFFE0E0E0),
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
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5722),
                  borderRadius: BorderRadius.circular(4),
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

class TaxiIcon extends StatelessWidget {
  const TaxiIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 40,
      child: CustomPaint(
        painter: TaxiPainter(),
      ),
    );
  }
}

class TaxiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Draw taxi body shadow
    paint.color = Colors.black.withOpacity(0.2);
    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(6, 16, size.width - 10, size.height - 25),
      const Radius.circular(5),
    );
    canvas.drawRRect(shadowRect, paint);

    // Draw taxi body
    paint.color = const Color(0xFFFFD700);
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(5, 15, size.width - 10, size.height - 25),
      const Radius.circular(5),
    );
    canvas.drawRRect(bodyRect, paint);

    // Draw taxi sign background
    paint.color = Colors.black;
    final signRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(15, 5, size.width - 30, 10),
      const Radius.circular(2),
    );
    canvas.drawRRect(signRect, paint);

    // Draw "TAXI" text
    final textSpan = TextSpan(
      text: 'TAXI',
      style: TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.bold,
        fontFamily: 'Arial',
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, Offset(size.width / 2 - textPainter.width / 2, 6));

    // Draw wheels
    paint.color = const Color(0xFF2C2C2C);
    canvas.drawCircle(Offset(15, size.height - 5), 4, paint);
    canvas.drawCircle(Offset(size.width - 15, size.height - 5), 4, paint);

    // Draw wheel rims
    paint.color = const Color(0xFF666666);
    canvas.drawCircle(Offset(15, size.height - 5), 2, paint);
    canvas.drawCircle(Offset(size.width - 15, size.height - 5), 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw main roads (light gray)
    paint.color = const Color(0xFFD0D0D0);
    paint.strokeWidth = 3;

    // Horizontal roads
    canvas.drawLine(
      Offset(0, size.height * 0.25),
      Offset(size.width, size.height * 0.25),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.45),
      Offset(size.width, size.height * 0.45),
      paint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.65),
      paint,
    );

    // Vertical roads
    canvas.drawLine(
      Offset(size.width * 0.15, 0),
      Offset(size.width * 0.15, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.35, 0),
      Offset(size.width * 0.35, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.75, size.height),
      paint,
    );

    // Draw main highway (yellow/orange)
    paint.color = const Color(0xFFFFC107);
    paint.strokeWidth = 8;
    canvas.drawLine(
      Offset(size.width * 0.55, 0),
      Offset(size.width * 0.55, size.height),
      paint,
    );

    // Draw area labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // IZGHAWA label
    textPainter.text = const TextSpan(
      text: 'IZGHAWA\nإزغاوة',
      style: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.05, size.height * 0.08));

    // AL WADI COMPOUND label
    textPainter.text = const TextSpan(
      text: 'AL WADI\nCOMPOUND\nالوادي',
      style: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.25, size.height * 0.12));

    // AL DUHA label
    textPainter.text = const TextSpan(
      text: 'AL DUHA\nالدحة',
      style: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.8, size.height * 0.2));

    // AL RAYYAN label
    textPainter.text = const TextSpan(
      text: 'AL RAYYAN',
      style: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.8, size.height * 0.85));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

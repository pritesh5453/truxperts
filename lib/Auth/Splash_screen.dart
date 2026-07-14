import 'package:flutter/material.dart';
import 'package:truxperts/appcolors.dart';
import 'package:truxperts/logowidget.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        children: [
          // Faint background location-pin watermark
          Positioned(
            top: 170,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.location_on,
                size: 190,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          // Centered logo
          const Center(
            child: LogoWidget(
              dark: true,
              markFontSize: 78,
              nameFontSize: 46,
            ),
          ),

          // City skyline silhouette + loading indicator
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _SkylinePainter(),
                  ),
                ),
                Container(
                  color: AppColors.navyDark,
                  padding: const EdgeInsets.only(bottom: 40, top: 18),
                  child: Column(
                    children: [
                      const Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, _) => LinearProgressIndicator(
                              value: _controller.value,
                              minHeight: 5,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.orange,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple flat-roof city skyline silhouette drawn behind the loading bar.
class _SkylinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.06);
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(0, h);
    final buildings = [
      [0.0, 0.55],
      [0.08, 0.35],
      [0.16, 0.65],
      [0.24, 0.25],
      [0.32, 0.5],
      [0.40, 0.3],
      [0.48, 0.6],
      [0.56, 0.4],
      [0.64, 0.55],
      [0.72, 0.28],
      [0.80, 0.5],
      [0.88, 0.35],
      [0.96, 0.6],
      [1.0, 0.45],
    ];

    for (final b in buildings) {
      path.lineTo(w * b[0], h * (1 - b[1]));
    }
    path.lineTo(w, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          context.go('/welcome');
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D6B4), // Teal/turquoise color
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: MediaQuery.of(context).size.height * 0,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Image.asset(
              'assets/splash_images/cloud_top_right.png',
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.20,
              fit: BoxFit.contain,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: 0,
            child: Image.asset(
              'assets/splash_images/cloud_left.png',
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.20,
              fit: BoxFit.contain,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20,
            left: 0,
            child: Image.asset(
              'assets/splash_images/tail_plane.png',
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.height * 0.15,
              fit: BoxFit.fill,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            right: MediaQuery.of(context).size.width * 0.35,
            child: Image.asset(
              'assets/splash_images/plane.png',
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              fit: BoxFit.contain,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            right: MediaQuery.of(context).size.width * 0.3,
            child: Image.asset(
              'assets/splash_images/cloud_bottom_right.png',
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              fit: BoxFit.contain,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: Image.asset(
              'assets/splash_images/tree_over_right.png',
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.20,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/splash_images/ground.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            child: Image.asset(
              'assets/splash_images/tree_left1.png',
              width: MediaQuery.of(context).size.width * 0.20,
              height: MediaQuery.of(context).size.height * 0.30,
              fit: BoxFit.contain,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 50,
            child: Image.asset(
              'assets/splash_images/tree_left2.png',
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.30,
              fit: BoxFit.contain,
              // color: const Color(0xFF00C5A5),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            right: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset(
              'assets/splash_images/hat.png',
              // width: 40,
              // color: const Color(0xFFFFD700), // Yellow color for hat
            ),
          ),

          // Main logo content
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Fellow4U Logo text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .end, // Thêm dòng này để căn lề phải
                        children: [
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                              children: [
                                TextSpan(text: 'Fellow'),
                              ],
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.end,
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                              children: [
                                TextSpan(
                                  text: '4U',
                                  style: TextStyle(
                                    fontSize: 36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/splash_images/fellow4u_logo.png',
                        width: 100,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

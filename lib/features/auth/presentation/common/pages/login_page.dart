import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  // Example credentials
  final String _correctEmail = 'yoojin@gmail.com';
  final String _correctPassword = '12345678';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'yoojin@gmail.com');
    _passwordController = TextEditingController(text: '12345678');
    _emailController.addListener(_printLatestValue);
    _passwordController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenHeight * 0.8, // 80% chiều cao màn hình
          maxHeight: screenHeight, // chiều cao tối đa
          minWidth: screenWidth * 0.8, // 80% chiều rộng màn hình
          maxWidth: screenWidth, // chiều rộng tối đa
        ),
        child: Stack(
          children: [
            // Background layer
            Container(
              color: const Color(0xFF1DE9B6),
            ),

            // Cloud vectors layer
            Stack(
              children: [
                Positioned(
                  top: 80,
                  right: 80,
                  child: Image.asset(
                    'assets/splash_images/tail_plane.png',
                    width: MediaQuery.of(context).size.width * 0.5,
                    fit: BoxFit.fill,
                    color: const Color(0xff05BD99),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 30,
                  child: Image.asset(
                    'assets/splash_images/plane.png',
                    width: 60,
                    fit: BoxFit.contain,
                    color: const Color(0xff05BD99),
                  ),
                ),
                Positioned(
                  top: 85,
                  right: 110,
                  child: Image.asset(
                    'assets/splash_images/cloud_bottom_right.png',
                    width: 50,
                    fit: BoxFit.contain,
                    color: const Color(0xff00CEA6),
                  ),
                ),
              ],
            ),

            // Logo layer
            Positioned(
              top: 40,
              left: 25,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  'assets/logo/fellow4u_logo.png',
                  width: 40,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Sign in form layer
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomPaint(
                painter: EllipticalNotchPainter(),
                child: Container(
                  padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1DE9B6)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Welcome back, Yoo Jin',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 40),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                enableSuggestions: false,
                                enableInteractiveSelection: true,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'yoojin@gmail.com',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF1DE9B6)),
                                  ),
                                  suffixIcon: _emailController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () =>
                                              _emailController.clear(),
                                        ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                style: const TextStyle(color: Colors.black),
                                obscureText: true,
                                autocorrect: false,
                                enableSuggestions: false,
                                enableInteractiveSelection: true,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'Enter your password',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xFF1DE9B6)),
                                  ),
                                  suffixIcon: _passwordController.text.isEmpty
                                      ? null
                                      : IconButton(
                                          icon: const Icon(Icons.clear),
                                          onPressed: () =>
                                              _passwordController.clear(),
                                        ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                              const SizedBox(height: 8),
                              if (_errorMessage != null)
                                Text(
                                  _errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text('Forgot Password',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                      textAlign: TextAlign.left),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Perform login logic
                              if (_emailController.text == _correctEmail &&
                                  _passwordController.text ==
                                      _correctPassword) {
                                setState(() {
                                  _errorMessage = null;
                                });

                                context.go('/traveler/home');
                                // Navigate to home page
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => const TravelerHomePage(),
                                //   ),
                                // );
                              } else {
                                // Incorrect credentials
                                setState(() {
                                  _errorMessage = 'Incorrect email or password';
                                  _passwordController.clear();
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1DE9B6),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('SIGN IN',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'or sign in with',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/icons/Facebook.png'),
                            const SizedBox(width: 16),
                            Image.asset('assets/icons/Talk.png'),
                            const SizedBox(width: 16),
                            Image.asset('assets/icons/Line.png'),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(color: Colors.grey),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: const Size(0, 0),
                                padding: EdgeInsets.all(0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                context.go('/register');
                              },
                              child: const Text('Sign Up',
                                  style: TextStyle(color: Color(0xFF1DE9B6))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EllipticalNotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 50);

    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      50,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

// StatelessWidget is used because the welcome screen does not need to manage changing data.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Defines the colour palette used throughout the welcome screen.
  static const Color cream = Color(0xFFFFF8F0);
  static const Color navy = Color(0xFF183F60);
  static const Color blue = Color(0xFF659BC3);
  static const Color lightBlue = Color(0xFFDCEBF6);
  static const Color white = Color(0xFFFFFDFC);
  static const Color grey = Color(0xFF7C858D);

  // Opens the login screen when the user selects the Log In button.
  void _openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  // Opens the registration screen when the user selects Create Account.
  void _openRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  // Builds and displays the welcome screen layout.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Center(
          // Limits the screen width to maintain a suitable layout.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              // Adds spacing around the screen content.
              padding: const EdgeInsets.symmetric(
                horizontal: 27,
                vertical: 20,
              ),
              child: Column(
                children: [

                  const SizedBox(height: 15),

                  // Displays the application logo at the top of the screen.
                  Image.asset(
                    'lib/images/logo.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 25),

                  // Displays the main welcome heading.
                  const Text(
                    'Welcome!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: navy,
                      letterSpacing: -0.8,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Displays the application's tagline.
                  const Text(
                    'Know Your Rights.\nEmpower Yourself.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.4,
                      fontWeight: FontWeight.w700,
                      color: blue,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Creates a decorative divider below the tagline.
                  Container(
                    height: 3,
                    width: 65,
                    decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Briefly explains the purpose of the application.
                  const Text(
                    'Understand your rights and access '
                    'helpful information in one place.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: grey,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Displays an illustration inside a rounded container.
                  Container(
                    height: 260,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: ClipRRect(
                      // Clips the illustration to match the container's rounded corners.
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        'lib/images/register_illustration.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Creates the Log In button to open the login screen.
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: ElevatedButton(
                      onPressed: () {
                        // Passes the current context to the login navigation function.
                        _openLogin(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navy,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 17),

                  // Creates the Create Account button to open the registration screen.
                  SizedBox(
                    width: double.infinity,
                    height: 57,
                    child: OutlinedButton(
                      onPressed: () {
                        // Passes the current context to the registration navigation function.
                        _openRegister(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: white,
                        foregroundColor: navy,
                        side: const BorderSide(
                          color: navy,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Displays a short message at the bottom of the welcome screen.
                  const Text(
                    'Know Your Rights. Empower Yourself.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: grey,
                    ),
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'onboarding_screen2.dart';

// StatefulWidget is used because this screen contains an animation.
class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});

  // Creates the state object that manages this screen.
  @override
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

// Manages the animation and screen content.
class _OnboardingScreen1State extends State<OnboardingScreen1>
    with SingleTickerProviderStateMixin {

  // Defines the colour palette used throughout the onboarding screen.
  static const Color background = Color(0xFFFFF8F0);
  static const Color brown = Color(0xFF70452D);
  static const Color darkBrown = Color(0xFF563723);
  static const Color mutedBrown = Color(0xFF927761);
  static const Color lightBrown = Color(0xFFF1E2D1);

  // Controls the timing and repetition of the floating animation.
  late AnimationController _animationController;

  // Stores the changing vertical position of the illustration.
  late Animation<double> _floatingAnimation;

  // initState runs once when the screen is first created.
  @override
  void initState() {
    super.initState();

    // Creates an animation controller with a duration of three seconds.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Defines the starting and ending positions of the floating animation.
    _floatingAnimation = Tween<double>(
      begin: -7,
      end: 7,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Repeats the animation continuously in both directions.
    _animationController.repeat(reverse: true);
  }

  // Releases animation resources when the screen is removed.
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Navigates the user to the second onboarding screen.
  void _nextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnboardingScreen2(),
      ),
    );
  }

  // Builds and displays the onboarding screen layout.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Center(
          // Limits the screen width to maintain a suitable layout.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              // Adds spacing around the screen content.
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 18,
              ),
              child: Column(
                children: [

                  // Displays the application logo and application name.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/images/logo.png',
                        height: 42,
                        width: 42,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'KNOW YOUR RIGHTS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: brown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Displays a decorative label to introduce the application.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: lightBrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'KNOWLEDGE IS POWER',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.8,
                        color: brown,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Uses AnimatedBuilder to update the illustration's position.
                  AnimatedBuilder(
                    animation: _floatingAnimation,
                    builder: (context, child) {
                      // Moves the illustration vertically according to the animation.
                      return Transform.translate(
                        offset: Offset(
                          0,
                          _floatingAnimation.value,
                        ),
                        child: child,
                      );
                    },
                    // Loads the first onboarding illustration from the assets folder.
                    child: Image.asset(
                      'lib/images/onboarding 1.png',
                      height: 285,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Displays the main heading of the first onboarding screen.
                  const Text(
                    'Know Your Rights',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      height: 1.2,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.7,
                      color: darkBrown,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Provides a short introduction to the purpose of the application.
                  const Text(
                    'Learn about your fundamental rights '
                    'and access information that helps you '
                    'in everyday situations.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.7,
                      color: mutedBrown,
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Displays three indicators to show the user's onboarding progress.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _indicator(true),
                      _indicator(false),
                      _indicator(false),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Creates the Next button to move to the second onboarding screen.
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brown,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
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

  // Creates a progress indicator based on whether the current page is active.
  Widget _indicator(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 7,
      width: active ? 25 : 7,
      decoration: BoxDecoration(
        color: active
            ? brown
            : const Color(0xFFDCC8B5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
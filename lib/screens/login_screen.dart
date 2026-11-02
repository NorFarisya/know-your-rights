import 'package:flutter/material.dart';
import 'register_screen.dart';

// StatefulWidget is used because the login screen contains changing data,
// such as password visibility and form input.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  // Creates the state object that manages the login screen.
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Identifies and manages the login form for validation.
  final _formKey = GlobalKey<FormState>();

  // Stores the email address entered by the user.
  final TextEditingController _emailController =
      TextEditingController();

  // Stores the password entered by the user.
  final TextEditingController _passwordController =
      TextEditingController();

  // Controls whether the password is displayed or hidden.
  bool _obscurePassword = true;

  // Defines the colour palette used throughout the login screen.
  static const Color cream = Color(0xFFFFF8F0);
  static const Color navy = Color(0xFF183F60);
  static const Color blue = Color(0xFF659BC3);
  static const Color lightBlue = Color(0xFFDCEBF6);
  static const Color borderBlue = Color(0xFFCAD9E5);
  static const Color grey = Color(0xFF7C858D);
  static const Color white = Color(0xFFFFFDFC);

  // Releases the text controllers when the screen is removed
  // to prevent unnecessary memory usage.
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Displays a SnackBar message to provide feedback to the user.
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: navy,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Checks whether the login form contains valid information.
  void _login() {
    if (_formKey.currentState!.validate()) {
      // Displays a message because login authentication
      // has not yet been connected to the backend.
      _showMessage('Login authentication will be connected next.');
    }
  }

  // Creates a reusable input field decoration.
  // This keeps the email and password fields visually consistent.
  InputDecoration _fieldDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      // Displays placeholder text inside the input field.
      hintText: hint,
      hintStyle: const TextStyle(
        color: grey,
        fontSize: 14,
      ),

      // Displays an icon at the beginning of the input field.
      prefixIcon: Icon(icon, color: navy),

      // Applies a background colour to the input field.
      filled: true,
      fillColor: white,

      // Adds internal spacing around the input text.
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 19,
      ),

      // Defines the border when the input field is not selected.
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: borderBlue),
      ),

      // Changes the border appearance when the user selects the field.
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: blue,
          width: 1.7,
        ),
      ),

      // Displays a red border when the input contains an error.
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),

      // Maintains the error border when an invalid field is selected.
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }

  // Creates reusable social login buttons for Google and Apple.
  Widget _socialButton(IconData icon, String label) {
    return Expanded(
      child: OutlinedButton.icon(
        // Displays a message because social authentication is not connected yet.
        onPressed: () {
          _showMessage('$label sign-in will be connected later.');
        },

        // Displays the social platform icon.
        icon: Icon(icon, color: navy, size: 25),

        // Displays the name of the social login option.
        label: Text(
          label,
          style: const TextStyle(
            color: navy,
            fontWeight: FontWeight.w700,
          ),
        ),

        // Defines the appearance and shape of the social login button.
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 53),
          backgroundColor: white,
          side: const BorderSide(color: borderBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }

  // Builds and displays the login screen layout.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            // Limits the screen width for a consistent layout.
            constraints: const BoxConstraints(maxWidth: 430),
            child: SingleChildScrollView(
              // Adds spacing around the login screen content.
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),

              // Connects the input fields to the form validation system.
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // Provides a back button to return to the previous screen.
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: navy,
                        ),
                      ),
                    ),

                    // Displays the application logo.
                    Image.asset(
                      'lib/images/logo.png',
                      height: 78,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 12),

                    // Displays the login illustration.
                    Image.asset(
                      'lib/images/login_illustration.png',
                      height: 230,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 5),

                    // Displays the main heading of the login screen.
                    const Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 7),

                    // Displays a short welcome message below the heading.
                    const Text(
                      'Your journey to awareness continues.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: blue,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Displays the label for the email input field.
                    const Text(
                      'Email Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: navy,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // Allows the user to enter their email address.
                    TextFormField(
                      controller: _emailController,

                      // Opens an email-friendly keyboard.
                      keyboardType: TextInputType.emailAddress,

                      // Applies the reusable email field decoration.
                      decoration: _fieldDecoration(
                        'Enter your email address',
                        Icons.email_outlined,
                      ),

                      // Checks whether the entered email address is valid.
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email address.';
                        }

                        // Uses a regular expression to check the email format.
                        if (!RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        ).hasMatch(value.trim())) {
                          return 'Please enter a valid email.';
                        }

                        // Returns null when the email passes validation.
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    // Displays the label for the password input field.
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: navy,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // Allows the user to enter their password.
                    TextFormField(
                      controller: _passwordController,

                      // Hides the password characters when enabled.
                      obscureText: _obscurePassword,

                      // Applies the password field decoration and visibility button.
                      decoration: _fieldDecoration(
                        'Enter your password',
                        Icons.lock_outline_rounded,
                      ).copyWith(

                        // Adds a button to show or hide the password.
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Updates the password visibility when the button is pressed.
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },

                          // Changes the icon according to password visibility.
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: navy,
                          ),
                        ),
                      ),

                      // Checks whether the password meets the required conditions.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }

                        // Ensures the password contains at least six characters.
                        if (value.length < 6) {
                          return 'Password must contain at least 6 characters.';
                        }

                        // Returns null when the password passes validation.
                        return null;
                      },
                    ),

                    // Displays the Forgot Password option.
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Displays a message because password recovery
                          // has not been implemented yet.
                          _showMessage(
                            'Password recovery will be added later.',
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: navy,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Creates the main login button.
                    SizedBox(
                      height: 57,
                      child: ElevatedButton(
                        // Calls the login function when the button is pressed.
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navy,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19),
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
                            SizedBox(width: 17),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Separates the regular login option from social login options.
                    const Row(
                      children: [
                        Expanded(child: Divider(color: borderBlue)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: TextStyle(
                              fontSize: 11,
                              color: navy,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: borderBlue)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Displays Google and Apple sign-in buttons.
                    Row(
                      children: [
                        _socialButton(
                          Icons.g_mobiledata_rounded,
                          'Google',
                        ),
                        const SizedBox(width: 13),
                        _socialButton(
                          Icons.apple,
                          'Apple',
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Provides a link for users who do not have an account.
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: grey),
                          ),

                          // Navigates to the registration screen.
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Create Now',
                              style: TextStyle(
                                color: navy,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Displays the application's tagline at the bottom.
                    const Text(
                      'Know Your Rights. Empower Yourself.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: navy,
                        fontStyle: FontStyle.italic,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

// StatefulWidget is used because the registration screen
// manages user input and password visibility.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  // Creates the state object that manages the registration screen.
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // Identifies and manages the registration form for validation.
  final _formKey = GlobalKey<FormState>();

  // Stores the full name entered by the user.
  final TextEditingController _nameController =
      TextEditingController();

  // Stores the email address entered by the user.
  final TextEditingController _emailController =
      TextEditingController();

  // Stores the password entered by the user.
  final TextEditingController _passwordController =
      TextEditingController();

  // Stores the password entered in the confirmation field.
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Controls whether the password and confirm password are visible.
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Defines the colour palette used throughout the registration screen.
  static const Color cream = Color(0xFFFFF8F0);
  static const Color navy = Color(0xFF183F60);
  static const Color blue = Color(0xFF659BC3);
  static const Color borderBlue = Color(0xFFCAD9E5);
  static const Color grey = Color(0xFF7C858D);
  static const Color white = Color(0xFFFFFDFC);

  // Releases all text controllers when the screen is removed
  // to prevent unnecessary memory usage.
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

// Checks the registration form and navigates to Dashboard
// when all entered information is valid.
void _register() {
  if (_formKey.currentState!.validate()) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }
}

  // Creates a reusable input field decoration.
  // This keeps the appearance of all registration fields consistent.
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
        vertical: 18,
      ),

      // Defines the border when the input field is not selected.
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(color: borderBlue),
      ),

      // Changes the border appearance when the input field is selected.
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

  // Creates reusable social registration buttons for Google and Apple.
  Widget _socialButton(IconData icon, String label) {
    return Expanded(
      child: OutlinedButton.icon(
        // Displays a message because social registration is not connected yet.
        onPressed: () {
          _showMessage('$label sign-up will be connected later.');
        },

        // Displays the social platform icon.
        icon: Icon(icon, color: navy, size: 25),

        // Displays the name of the social registration option.
        label: Text(
          label,
          style: const TextStyle(
            color: navy,
            fontWeight: FontWeight.w700,
          ),
        ),

        // Defines the appearance and shape of the social registration button.
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

  // Creates a reusable password input field.
  // The same function is used for both password and confirm password.
  Widget _passwordField({
    required String hint,
    required bool obscure,
    required VoidCallback toggle,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      // Connects the field to its corresponding text controller.
      controller: controller,

      // Hides the password characters when enabled.
      obscureText: obscure,

      decoration: _fieldDecoration(
        hint,
        Icons.lock_outline_rounded,
      ).copyWith(
        // Adds a button to show or hide the password.
        suffixIcon: IconButton(
          onPressed: toggle,

          // Changes the icon according to password visibility.
          icon: Icon(
            obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: navy,
          ),
        ),
      ),

      // Applies the validation rules provided when calling this function.
      validator: validator,
    );
  }

  // Builds and displays the registration screen layout.
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
              // Adds spacing around the registration screen content.
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
                          Navigator.pop(context);
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

                    const SizedBox(height: 10),

                    // Displays the registration illustration.
                    Image.asset(
                      'lib/images/register_illustration.png',
                      height: 220,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 5),

                    // Displays the main heading of the registration screen.
                    const Text(
                      'Create Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: navy,
                      ),
                    ),

                    const SizedBox(height: 7),

                    // Displays a short message below the registration heading.
                    const Text(
                      'Join us and start exploring your rights.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: blue,
                      ),
                    ),

                    const SizedBox(height: 27),

                    // Displays the label for the full name input field.
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: navy,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // Allows the user to enter their full name.
                    TextFormField(
                      controller: _nameController,

                      // Automatically capitalises the first letter of each word.
                      textCapitalization: TextCapitalization.words,

                      // Applies the reusable input field decoration.
                      decoration: _fieldDecoration(
                        'Enter your full name',
                        Icons.person_outline_rounded,
                      ),

                      // Checks whether the user has entered their full name.
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name.';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

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

                      // Applies the reusable input field decoration.
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

                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

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

                    // Creates the password field using the reusable function.
                    _passwordField(
                      hint: 'Create a password',
                      obscure: _obscurePassword,
                      controller: _passwordController,

                      // Updates password visibility when the eye icon is pressed.
                      toggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },

                      // Checks whether the password meets the required conditions.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please create a password.';
                        }

                        // Ensures the password contains at least six characters.
                        if (value.length < 6) {
                          return 'Password must contain at least 6 characters.';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    // Displays the label for the confirm password input field.
                    const Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: navy,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 9),

                    // Creates the confirm password field using the reusable function.
                    _passwordField(
                      hint: 'Confirm your password',
                      obscure: _obscureConfirmPassword,
                      controller: _confirmPasswordController,

                      // Updates confirm password visibility when the eye icon is pressed.
                      toggle: () {
                        setState(() {
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword;
                        });
                      },

                      // Checks whether the confirmation matches the original password.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password.';
                        }

                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Creates the main Create Account button.
                    SizedBox(
                      height: 57,
                      child: ElevatedButton(
                        // Calls the registration function when the button is pressed.
                        onPressed: _register,
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
                              'Create Account',
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

                    const SizedBox(height: 27),

                    // Separates regular registration from social registration options.
                    const Row(
                      children: [
                        Expanded(child: Divider(color: borderBlue)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR SIGN UP WITH',
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

                    // Displays Google and Apple registration buttons.
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

                    const SizedBox(height: 27),

                    // Provides a link for users who already have an account.
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: grey),
                          ),

                          // Returns the user to the previous screen when Log In is selected.
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Log In',
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
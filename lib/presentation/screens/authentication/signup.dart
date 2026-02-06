import 'package:flutter/material.dart';
import 'package:project/core/constant/Color/colors.dart';
import 'package:project/core/constant/Widgets/common_widgets.dart';
import 'package:project/data/firebase_service/services.dart';
import 'package:project/presentation/screens/authentication/email_login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseService _authService = FirebaseService();

  bool _isLoading = false;
  String? _error;

  Future<void> _handleSignup() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    final error = await _authService.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (error == null) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmailLoginPage()),
        );
      }
    } else {
      setState(() => _error = error);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign Up',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      StyledTextField(
                        controller: _nameController,
                        labelText: 'Name',
                      ),
                      StyledTextField(
                        controller: _emailController,
                        labelText: 'Email',
                      ),
                      StyledTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                      ),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: AppColors.buttonGradient,
                              ),
                              child: ElevatedButton(
                                onPressed: _handleSignup,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                      TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const EmailLoginPage())),
                        child: const Text("Already have an account? Login"),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 10),
                        Text(_error!,
                            style: const TextStyle(color: Colors.red)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

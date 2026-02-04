import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/core/constant/Color/colors.dart';
import 'package:project/presentation/authentication/otp_screen.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _phoneNumber = '';
  bool _isLoading = false;
  String? _status;

  // 🔥 SAME logic you used in PhoneNumberPage
  Future<void> _verifyPhone() async {
    if (_phoneNumber.isEmpty) {
      setState(() => _status = "Enter phone number");
      return;
    }

    setState(() {
      _isLoading = true;
      _status = null;
    });

    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumber,

      /// auto verify (Android sometimes)
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },

      /// error
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _status = e.message;
          _isLoading = false;
        });
      },

      /// OTP sent
      codeSent: (String verificationId, int? resendToken) {
        setState(() => _isLoading = false);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Otpscreen(
              verificationId: verificationId,
              phone: _phoneNumber,
            ),
          ),
        );
      },

      codeAutoRetrievalTimeout: (_) {},
      timeout: const Duration(seconds: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// image
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Transform.flip(
                      flipX: true,
                      child: Image.asset(
                        'assets/images/man.png',
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),

              const Text(
                'Login with your Phone Number',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              IntlPhoneField(
                disableAutoFillHints: true,
                initialCountryCode: 'IN',

                // typed text color
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),

                // +91 color
                dropdownTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),

                cursorColor: Colors.pinkAccent,

                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  labelText: 'Enter phone number',
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1E1E1E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                onChanged: (phone) {
                  _phoneNumber = phone.completeNumber;
                },
              ),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: AppColors.buttonGradient,
                      ),
                      child: ElevatedButton(
                        onPressed: _verifyPhone, // 🔥 changed here
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

              if (_status != null) ...[
                const SizedBox(height: 12),
                Text(
                  _status!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

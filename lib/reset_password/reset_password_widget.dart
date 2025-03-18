// request_reset_password.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lingualy_app/reset_password/confirm_reset_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../Amplify/AuthService.dart';

class RequestResetPasswordWidget extends StatefulWidget {
  const RequestResetPasswordWidget({super.key});

  @override
  State<RequestResetPasswordWidget> createState() => _RequestResetPasswordWidgetState();
}

class _RequestResetPasswordWidgetState extends State<RequestResetPasswordWidget>
    with TickerProviderStateMixin {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  bool _isLoading = false;
  String? _message;
  bool _isError = false;

  final animationsMap = {
    'textOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effectsBuilder: () => [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.0.ms,
          duration: 2000.0.ms,
          begin: 0.105,
          end: 1.0,
        ),
      ],
    ),
    'textOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effectsBuilder: () => [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.0.ms,
          duration: 600.0.ms,
          begin: 0.515,
          end: 1.0,
        ),
      ],
    ),
  };

  Future<void> _requestResetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _message = 'Please enter your email address';
        _isError = true;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      final response = await _authService.resetPassword(_emailController.text.trim());
      setState(() {
        _message = response;
        _isError = false;
      });

      // Navigate to confirm reset password screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmResetPasswordWidget(
              email: _emailController.text.trim(),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _message = e.toString();
        _isError = true;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F5F9),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 300.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xC13D39AB)],
                    stops: [0.0, 1.0],
                    begin: AlignmentDirectional(0.0, -1.0),
                    end: AlignmentDirectional(0, 1.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reset Password',
                        style: FlutterFlowTheme.of(context).displayMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                      Text(
                        'Enter your email to reset password',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Manrope',
                          color: const Color(0xFFE0E0E0),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation2']!),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        decoration: const InputDecoration(
                          labelText: 'Enter your email:',
                          filled: true,
                          fillColor: Color(0xFFF5F7FA),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 24),
                      if (_message != null)
                        Text(
                          _message!,
                          style: TextStyle(
                            color: _isError ? Colors.red : Colors.green,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _requestResetPassword,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Send Reset Code'),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                                (route) => false,
                          );
                        },
                        child: const Text('Back to Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
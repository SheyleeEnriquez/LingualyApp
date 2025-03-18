// confirm_reset_password.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lingualy_app/escenarios/escenarios_model.dart';
import 'package:lingualy_app/flutter_flow/flutter_flow_util.dart';
import 'package:lingualy_app/reset_password/reset_password_model.dart';
import '../flutter_flow/flutter_flow_model.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../Amplify/AuthService.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class ConfirmResetPasswordWidget extends StatefulWidget {
  final String email;

  const ConfirmResetPasswordWidget({
    super.key,
    required this.email,
  });

  @override
  State<ConfirmResetPasswordWidget> createState() => _ConfirmResetPasswordWidgetState();
}

class _ConfirmResetPasswordWidgetState extends State<ConfirmResetPasswordWidget>
    with TickerProviderStateMixin {
  late ResetPasswordModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _authService = AuthService();

  String? _errorMessage;
  bool _isLoading = false;


  bool _showRequirements = false;

  // Estados de validación de la contraseña
  bool _hasMinLength = false;
  bool _hasUpperLower = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPasswordModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController2!.addListener(_validatePassword);
    _model.textFieldFocusNode2!.addListener(() {
      setState(() {
        _showRequirements = _model.textFieldFocusNode2!.hasFocus;
      });
    });

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    animationsMap.addAll({
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(

            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.185,
            end: 1.0,
          ),
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 600.0.ms,
            duration: 1060.0.ms,
            color: const Color(0xFF959CB8),
            angle: 0.524,
          ),
        ],
      ),
      'textOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 520.0.ms,
            begin: 0.125,
            end: 1.0,
          ),
        ],
      ),
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  void _validatePassword() {
    String password = _model.textController2!.text;
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUpperLower = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
      _hasNumber = RegExp(r'\d').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

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
                        'Confirm Reset',
                        style: FlutterFlowTheme.of(context).displayMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
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
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _model.textController1,
                              focusNode: _model.textFieldFocusNode1,
                              decoration: const InputDecoration(
                                labelText: 'Enter verification code:',
                                filled: true,
                                fillColor: Color(0xFFF5F7FA),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                            TextFormField(
                              controller: _model.textController2,
                              focusNode: _model.textFieldFocusNode2,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              obscureText: !_model.passwordVisibility2,
                              validator: _model.textController2Validator
                                  .asValidator(context),
                              decoration: InputDecoration(
                                labelText: 'Enter new password:',
                                filled: true,
                                fillColor: const Color(0xFFF5F7FA),
                                labelStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _model.passwordVisibility2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _model.passwordVisibility2 = !_model.passwordVisibility2;
                                    });
                                  },
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                            if (_showRequirements) ...[
                              const SizedBox(height: 8.0),
                              _buildRequirement("Al menos 8 caracteres", _hasMinLength),
                              _buildRequirement("Mayúsculas y minúsculas", _hasUpperLower),
                              _buildRequirement("Al menos un número", _hasNumber),
                              _buildRequirement("Al menos un carácter especial", _hasSpecialChar),
                            ],
                            TextFormField(
                              controller: _model.textController3,
                              focusNode: _model.textFieldFocusNode3,
                              obscureText: !_model.passwordVisibility3,
                              decoration: InputDecoration(
                                labelText: 'Confirm new password:',
                                filled: true,
                                fillColor: const Color(0xFFF5F7FA),
                                labelStyle: const TextStyle(color: Colors.black),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _model.passwordVisibility3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _model.passwordVisibility3 = !_model.passwordVisibility3;
                                    });
                                  },
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                            if (_errorMessage != null)
                              Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _confirmResetPassword();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFF2F90F7),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              child: Text('Reset Password'),
                              ),
                          ].divide(const SizedBox(height: 16.0)),
                        ),
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
  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle_outline : Icons.cancel_outlined,
          color: isMet ? Colors.green : Colors.red,
          size: 18,
        ),
        const SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            color: isMet ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Future<void> _confirmResetPassword() async {
    if (_model.textController2?.text != _model.textController3?.text) {
      setState(() {
        _isLoading = true;
        _errorMessage = 'Passwords do not match';
      });
      return;
    }
    setState(() {
      _errorMessage = null;
    });

    try {
      await _authService.confirmResetPassword(
          username: widget.email,
          newPassword: _model.textController2.text,
          confirmationCode: _model.textController1.text
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset successfully!'),backgroundColor: Colors.lightGreen,),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
              (route) => false,
        );
      }
    } on AuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
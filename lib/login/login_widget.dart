import 'package:lingualy_app/reset_password/reset_password_widget.dart';

import '../Amplify/AuthService.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'login_model.dart';
export 'login_model.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();


    animationsMap.addAll({
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
      'textOnPageLoadAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 1010.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF0F5F9),
        body: Column(
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
                      'Lingualy App',
                      style: FlutterFlowTheme.of(context).displayMedium.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation1']!),
                    Text(
                      'Improve your writing skills',
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

            // 🔥 Envolver en un Expanded para evitar el overflow
            Expanded(
              child: SingleChildScrollView(
                child: Container(
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
                        Text(
                          'Log In',
                          style: FlutterFlowTheme.of(context).headlineMedium.override(
                            fontFamily: 'Outfit',
                            color: const Color(0xFF161C24),
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation3']!),
                        TextFormField(
                          controller: _model.textController1,
                          focusNode: _model.textFieldFocusNode1,
                          decoration: const InputDecoration(
                            labelText: 'Enter your username or email:',
                            filled: true,
                            fillColor: Color(0xFFF5F7FA),
                            labelStyle: TextStyle(color: Colors.black),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          obscureText: !_model.passwordVisibility,
                          decoration: InputDecoration(
                            labelText: 'Enter your password:',
                            filled: true,
                            fillColor: const Color(0xFFF5F7FA),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _model.passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _model.passwordVisibility = !_model.passwordVisibility;
                                });
                              },
                            ),
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 24),
                        if (_errorMessage != null)
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signIn,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Start Learning'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestResetPasswordWidget()),
                            );
                          },
                          child: const Text('Forgot your password? Reset it'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/registro');
                          },
                          child: const Text('Don\'t have an account? Sign Up'),
                        )
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

 Future<void> _signIn() async {
  setState(() {
    _isLoading = true;
    _errorMessage = null;
  });

  final username = _model.textController1.text.trim();
  final password = _model.textController2.text;

  if (username.isEmpty || password.isEmpty) {
    setState(() {
      _errorMessage = 'Username and password cannot be empty.';
      _isLoading = false;
    });
    return;
  }

  final result = await _authService.signIn(username, password);

  if (result == null) {
    // Redirigir al menú principal
    Navigator.pushNamed(context, '/menu');
  } else {
    setState(() {
      _errorMessage = result;
      _isLoading = false;
    });
  }
}

}

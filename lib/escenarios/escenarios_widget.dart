import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../Amplify/AuthService.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'escenarios_model.dart';
export 'escenarios_model.dart';
import 'package:http/http.dart' as http;

class EscenariosWidget extends StatefulWidget {
  final String title;
  final String description;
  final String id; // Puede ser int si lo manejas como número

  const EscenariosWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
  }) : super(key: key);

  @override
  State<EscenariosWidget> createState() => _EscenariosWidgetState();
}

class _EscenariosWidgetState extends State<EscenariosWidget>
    with TickerProviderStateMixin {
  late EscenariosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  Map<String, dynamic> _userInfo = {};
  final AuthService _authService = AuthService();

  String? correctedAnswer;
  String? score;
  String? tone;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EscenariosModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 320.0.ms,
            duration: 1490.0.ms,
            color: const Color(0x4C3969EF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  Future<void> submitAnswer() async {
    final userInfo = await _authService.getUserInfo();

    setState(() {
      _userInfo = userInfo;
      isLoading = true;
    });

    try {
      final uri = Uri.parse('http://lingualyapp.us-east-2.elasticbeanstalk.com/api/corrections');

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': _userInfo['userId'],
          'scenarioId': int.parse(widget.id),
          'userAnswer': _model.textController?.text ?? '',
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          correctedAnswer = data['data']['corrected_answer'];  // Need to access 'data' first
          score = data['data']['readability_score'];           // Need to access 'data' first
          tone = (data['data']['tones'] as List).join(', ');
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correction received.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          //SnackBar(content: Text('Conexión exitosa, pero error en la respuesta (${response.statusCode}).')),
          SnackBar(content: Text('Theres are some errors in the system. Please try later.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $error')),
      );
    }

    setState(() {
      isLoading = false;
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
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFFF0F5F9),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                      stops: [0.0, 1.0],
                      begin: AlignmentDirectional(0.0, -1.0),
                      end: AlignmentDirectional(0, 1.0),
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scenario',
                          style: FlutterFlowTheme.of(context)
                              .displayMedium
                              .override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                                fontSize: 45.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ).animateOnPageLoad(
                            animationsMap['textOnPageLoadAnimation']!),
                        Text(
                          'Try your best for this email. :)',
                          style:
                              FlutterFlowTheme.of(context).bodyLarge.override(
                                    fontFamily: 'Inter',
                                    color: const Color(0xFFE0E0E0),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    widget.title, // Usamos el título dinámico
                                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                                      fontFamily: 'Inter Tight',
                                      color: const Color(0xFF161C24),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    widget.description, // Usamos la descripción dinámica
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      color: const Color(0xFF636F81),
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                        color: const Color(0xFFE0E3E7),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _model.textController,
                                      focusNode: _model.textFieldFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Write your answer here... :)',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Inter',
                                              letterSpacing: 0.0,
                                              color: Colors.black,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            letterSpacing: 0.0,
                                            color: Colors.black,
                                          ),
                                      maxLines: 12,
                                      minLines: 8,
                                      validator: _model.textControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 16.0)),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FFButtonWidget(
                              onPressed: isLoading ? null : submitAnswer,
                              text: isLoading ? 'Reviewing...' : 'Review',
                              options: FFButtonOptions(
                                width: 150.0,
                                height: 50.0,
                                padding: const EdgeInsets.all(8.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: const Color(0xFF2797FF),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: Colors.white,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                              Navigator.of(context).pushReplacementNamed('/menu');
                              },
                              text: 'Back',
                              options: FFButtonOptions(
                                width: 150.0,
                                height: 50.0,
                                padding: const EdgeInsets.all(8.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Inter Tight',
                                      color: const Color(0xFF636F81),
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Color(0xFFE0E3E7),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),

                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: Color(0xFF1A73E8), size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Corrected Answer:',
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: 'Inter Tight',
                                color: const Color(0xFF1A73E8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Card(
                          color: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              correctedAnswer ?? 'No correction available',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),


                        const SizedBox(height: 10.0),

                        Row(
                          children: [
                            const Icon(Icons.star_border, color: Color(0xFFFFA726), size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Score: ${score ?? "N/A"}',
                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                fontFamily: 'Inter Tight',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFA726),
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(height: 10.0),

                        Row(
                          children: [
                            const Icon(Icons.palette_outlined, color: Color(0xFF43A047), size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Tone: ${tone?.isNotEmpty == true ? tone : "N/A"}',
                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                fontFamily: 'Inter Tight',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF43A047),
                              ),
                            ),
                          ],
                        ),


                      ].divide(const SizedBox(height: 24.0)),
                    ),
                  ),
                ),
              ].divide(const SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}

import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_reset_widget.dart' show ConfirmResetPasswordWidget;
import 'package:flutter/material.dart';

class ResetPasswordModel extends FlutterFlowModel<ConfirmResetPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? textController2Validator = (BuildContext context, String? value) {
    if (value == null || value.isEmpty) return 'La contraseña no puede estar vacía';
    if (value.length < 8) return 'Requerimientos no completados';
    if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(value)) return 'Requerimientos no completados';
    if (!RegExp(r'\d').hasMatch(value)) return 'Requerimientos no completados';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Requerimientos no completados';
    return null;
  };

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  late bool passwordVisibility3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {
    passwordVisibility2 = false;
    passwordVisibility3 = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}

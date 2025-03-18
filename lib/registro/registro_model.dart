import '/flutter_flow/flutter_flow_util.dart';
import 'registro_widget.dart' show RegistroWidget;
import 'package:flutter/material.dart';

class RegistroModel extends FlutterFlowModel<RegistroWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator = (BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "The field cannot be empty";
    }else {
      final expresion = RegExp(r"^[a-zA-Z\s]+$");
      if(!expresion.hasMatch(value)){
        return "The name field can only contain letters";
      }
    }
  return null; // No hay error
  };
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator = (BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "The field cannot be empty";
    }else {
      final expresion = RegExp(r"^[a-zA-Z\s]+$");
      if(!expresion.hasMatch(value)){
        return "The last name field can only contain letters";
      }
    }
    return null; // No hay error
  };
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator = (BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return "The field cannot be empty";
    }else {
      final expresion = RegExp(r"^[\w.-]+@[a-zA-Z\d.-]+\.[a-zA-Z]{2,}$");
      if(!expresion.hasMatch(value)){
        return "Please enter a valid format for the email";
      }
    }
    return null; // No hay error
  };
  //State field(s) for TextField widget
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController5;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? textController5Validator = (BuildContext context, String? value) {
    if (value == null || value.isEmpty) return 'La contraseña no puede estar vacía';
    if (value.length < 8) return 'Requerimientos no completados';
    if (!RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(value)) return 'Requerimientos no completados';
    if (!RegExp(r'\d').hasMatch(value)) return 'Requerimientos no completados';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) return 'Requerimientos no completados';
    return null;
  };


  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
    textFieldFocusNode5?.dispose();
    textController5?.dispose();
  }
}

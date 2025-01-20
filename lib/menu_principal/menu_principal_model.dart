import '/flutter_flow/flutter_flow_util.dart';
import 'menu_principal_widget.dart' show MenuPrincipalWidget;
import 'package:flutter/material.dart';

class MenuPrincipalModel extends FlutterFlowModel<MenuPrincipalWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Column widget.
  ScrollController? columnController;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
  }

  @override
  void dispose() {
    columnController?.dispose();
  }
}

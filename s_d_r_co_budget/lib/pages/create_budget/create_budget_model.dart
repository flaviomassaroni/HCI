import '/flutter_flow/flutter_flow_util.dart';
import 'create_budget_widget.dart' show CreateBudgetWidget;
import 'package:flutter/material.dart';

class CreateBudgetModel extends FlutterFlowModel<CreateBudgetWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  String? _textController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '8hzaiw1r' /* Please enter an amount */,
      );
    }

    return null;
  }

  // State field(s) for budgetName widget.
  FocusNode? budgetNameFocusNode;
  TextEditingController? budgetNameTextController;
  String? Function(BuildContext, String?)? budgetNameTextControllerValidator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {
    textController1Validator = _textController1Validator;
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    budgetNameFocusNode?.dispose();
    budgetNameTextController?.dispose();

    textFieldFocusNode2?.dispose();
    textController3?.dispose();
  }
}

import 'package:flutter/material.dart';

class FormController {
  TextEditingController textEditingController;
  String labelText;
  bool required;

  FormController({
    required this.textEditingController,
    required this.labelText,
    required this.required,
  });
}

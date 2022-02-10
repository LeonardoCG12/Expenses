import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextCapitalization textCapitalization;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final void Function(String) submitForm;

  const AdaptativeTextField({
    Key? key,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    required this.controller,
    required this.labelText,
    required this.submitForm,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CupertinoTextField(
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1?.color,
              ),
              controller: controller,
              padding: const EdgeInsets.all(8),
              textCapitalization: textCapitalization,
              keyboardType: keyboardType,
              placeholder: labelText,
              onSubmitted: submitForm,
            ),
          )
        : TextField(
            controller: controller,
            textCapitalization: textCapitalization,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: labelText,
            ),
            onSubmitted: submitForm,
          );
  }
}

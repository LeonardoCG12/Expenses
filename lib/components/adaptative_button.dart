import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  const AdaptativeButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: const Color(0xFF616161),
            padding: const EdgeInsets.all(15),
            onPressed: onPressed,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFFCCCCCC),
              ),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(label),
          );
  }
}

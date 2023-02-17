import 'package:flutter/material.dart';

class AdviceField extends StatelessWidget {
  final String advice;
  const AdviceField({required this.advice, super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: themeData.colorScheme.onPrimary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            '''" $advice "''',
            style: themeData.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

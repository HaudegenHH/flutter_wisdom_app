import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;

  const CustomButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onTap: () => onTap(),
      child: Material(
        elevation: 20,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: themeData.colorScheme.secondary,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Get advise",
              style: themeData.textTheme.headlineLarge,
            ),
          ),
        ),
      ),
    );
  }
}

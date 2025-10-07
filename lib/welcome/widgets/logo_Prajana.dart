import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoPrajana extends StatefulWidget {
  const LogoPrajana({super.key});

  @override
  State<LogoPrajana> createState() => _LogoPrajanaState();
}

class _LogoPrajanaState extends State<LogoPrajana> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.5),
      ),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: const Icon(Icons.ac_unit, color: Color(0xFFE6007A), size: 40), // Placeholder icon
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomNoBtn extends StatelessWidget {
  final VoidCallback ontap;
  final String text;

  const CustomNoBtn({super.key, required this.ontap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.black),
          ),
        ),
      ),
    );
  }
}

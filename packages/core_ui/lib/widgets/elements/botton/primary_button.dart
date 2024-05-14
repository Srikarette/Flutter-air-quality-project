import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.title, this.titleColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150, // กำหนดความกว้างของปุ่ม
      height: 50, // กำหนดความสูงของปุ่ม
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFEBEBEB),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: titleColor ?? Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
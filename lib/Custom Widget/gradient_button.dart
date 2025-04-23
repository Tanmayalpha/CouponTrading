import 'package:flutter/material.dart';

import '../Color/Color.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key,this.onTab, this.width,this.height,this.color,this.fSize,this.icon,this.title});

  final VoidCallback? onTab;

  final double? height;
  final double? width;
  final  double? fSize;
  final IconData? icon;
  final Color? color;
  final String? title;


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: GestureDetector(
        onTap: onTab,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary.withOpacity(0.9),
                colors.primary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                offset: const Offset(-3, -3),
                blurRadius: 6,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(3, 3),
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
          child:  Center(
            child: Text(
              title ?? 'Button',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const CircleButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: AppColors.mint,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.1),
                ],
                stops: const [0.7, 1.0],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../constants.dart';

class MoodSlider extends StatelessWidget {
  final String label;
  final String startLabel;
  final String endLabel;
  final double value;
  final ValueChanged<double> onChanged;

  const MoodSlider({
    super.key,
    required this.label,
    required this.startLabel,
    required this.endLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'InknutAntiqua',
            color: AppColors.navy,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              startLabel,
              style: const TextStyle(
                fontFamily: 'InknutAntiqua',
                color: AppColors.navy,
                fontSize: 12,
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.teal,
                  inactiveTrackColor: AppColors.mint,
                  thumbColor: AppColors.coral,
                  overlayColor: AppColors.coral.withOpacity(0.2),
                  trackHeight: 8,
                ),
                child: Slider(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
            Text(
              endLabel,
              style: const TextStyle(
                fontFamily: 'InknutAntiqua',
                color: AppColors.navy,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

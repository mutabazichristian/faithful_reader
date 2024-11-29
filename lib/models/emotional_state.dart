import 'package:flutter/material.dart';

class EmotionState {
  final double peace; // Peaceful <-> Anxious
  final double energy; // Energized <-> Exhausted
  final double outlook; // Hopeful <-> Discouraged
  final double connection; // Connected <-> Isolated
  final double clarity; // Clear <-> Confused

  EmotionState({
    required this.peace,
    required this.energy,
    required this.outlook,
    required this.connection,
    required this.clarity,
  });

  // Convert button selections to EmotionState
  static EmotionState fromSelectedFeelings(List<String> feelings) {
    double peace = 0.5;
    double energy = 0.5;
    double outlook = 0.5;
    double connection = 0.5;
    double clarity = 0.5;

    for (String feeling in feelings) {
      switch (feeling.toLowerCase()) {
        case 'peaceful':
          peace += 0.3;
          break;
        case 'anxious':
          peace -= 0.3;
          break;
        case ''
        // Add more mappings...
      }} 

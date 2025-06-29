import 'package:flutter/material.dart';

WidgetStateProperty<Color?> convertColorToMaterialStateProperty(Color color) {
  return WidgetStateProperty.resolveWith<Color?>(
    (Set<WidgetState> states) {
      // You can define different logic for states here.
      // For now, we'll return the same color for all states.
      return color;
    },
  );
}

WidgetStateProperty<double?> convertDoubleToMaterialStateProperty(
    double value) {
  return WidgetStateProperty.resolveWith<double?>(
    (Set<WidgetState> states) {
      // You can define different logic for states here.
      // For now, we'll return the same value for all states.
      return value;
    },
  );
}

import 'package:flutter/material.dart';

class PerformanceWidget extends StatelessWidget {
  final String widgetName;

  const PerformanceWidget({
    super.key,
    required this.widgetName,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('$widgetName rebuilt');

    return const SizedBox.shrink();
  }
}
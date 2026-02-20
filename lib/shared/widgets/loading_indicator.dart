import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/constants/app_colors.dart';

// reusable loading indicator used across all my screens
// one place to change the loading style for the whole app

class LoadingIndicator extends StatelessWidget {
  final Color? color;
  final double size;

  const LoadingIndicator({
    super.key,
    this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: color ?? AppColors.accent, // defaults to mint
        size: size,
      ),
    );
  }
}

// full screen loading overlay - used when waiting on auth calls
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.overlay,
      child: const LoadingIndicator(),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final Color? backgroundColor;
  final bool showIndicator;

  const LoadingView({
    this.backgroundColor,
    Key? key,
    this.showIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      body: Visibility(
        visible: showIndicator,
        child: const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ),
      ),
    );
  }
}
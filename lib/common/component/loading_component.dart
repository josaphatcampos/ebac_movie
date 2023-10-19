import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../sistem/colors.dart';

class LoadingComponent extends StatelessWidget {
  final ValueListenable<bool> isLoading;
  const LoadingComponent({
    super.key, required this.isLoading,
  }) ;


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, value, child) => Visibility(
        visible: value,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const Center(
            child: CircularProgressIndicator(
              color: CustomColors.red,
            ),
          ),
        ),
      ),
    );
  }
}

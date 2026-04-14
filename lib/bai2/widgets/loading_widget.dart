// bai2/widgets/loading_widget.dart
// Bài 2: Widget loading indicator

import 'package:flutter/material.dart';

/// Hiển thị vòng xoay loading ở giữa màn hình
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

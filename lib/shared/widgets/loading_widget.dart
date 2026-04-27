import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? label;

  const LoadingWidget({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (label != null) ...[
            const SizedBox(height: 12),
            Text(label!),
          ],
        ],
      ),
    );
  }
}

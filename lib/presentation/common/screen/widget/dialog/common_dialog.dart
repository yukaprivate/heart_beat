import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Card(
        elevation: 1,
        // shape: ,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

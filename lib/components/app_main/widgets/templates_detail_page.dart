import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/core/routing/router_configs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TemplatesDetailPage extends ConsumerWidget {
  const TemplatesDetailPage({
    super.key,
    required this.label,
    required this.bgColor,
  });

  final String label;

  final Color bgColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            ref.read(appRouterProvider).pop();
          },
          child: const Icon(Icons.close),
        ),
      ),
      body: Center(
        child: Text(label),
      ),
      backgroundColor: bgColor,
    );
  }
}

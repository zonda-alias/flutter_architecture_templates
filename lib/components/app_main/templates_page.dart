import 'package:flutter/material.dart';
import 'package:flutter_architecture_templates/core/routing/app_routers.dart';
import 'package:flutter_architecture_templates/core/routing/router_configs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TemplatesPage extends ConsumerStatefulWidget {
  const TemplatesPage({
    super.key,
    required this.label,
    required this.bgColor,
  });

  final String label;

  final Color bgColor;

  @override
  ConsumerState<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends ConsumerState<TemplatesPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.label),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            InkWell(
              onTap: () {
                // RequiredExtraRoute(
                //   $extra: Extra(
                //     '${widget.label}$_counter',
                //     widget.bgColor,
                //   ),
                // ).push(context);

                ref.read(appRouterProvider).push(
                      '/templates_detail',
                      extra: Extra(
                        '${widget.label}$_counter',
                        widget.bgColor,
                      ),
                    );
              },
              child: Container(
                width: 100,
                height: 80,
                color: Colors.deepPurpleAccent,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      backgroundColor: widget.bgColor,
    );
  }
}

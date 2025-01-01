import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/networking-view/view/pages/network_logger_home_page.dart';
import 'package:loggycian_flutter/src/view/loggycian_entry.dart';

class Loggycian extends StatefulWidget {
  const Loggycian({
    required this.app,
    this.visible = true,
    super.key,
  });
  final Widget app;
  final bool visible;

  @override
  State<Loggycian> createState() => _LoggycianState();
}

class _LoggycianState extends State<Loggycian> {
  final _showDebugButtonNotifier = ValueNotifier(true);

  @override
  void dispose() {
    _showDebugButtonNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return widget.app;
    return ValueListenableBuilder<bool>(
      valueListenable: _showDebugButtonNotifier,
      builder: (context, isVisible, _) {
        return Stack(
          children: [
            widget.app,
            LoggycianEntry(
              visible: isVisible,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => NetworkLoggerHomePage(
                    showDebugButtonNotifier: _showDebugButtonNotifier,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

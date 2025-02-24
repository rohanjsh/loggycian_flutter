import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/networking-view/view/pages/network_logger_home_page.dart';
import 'package:loggycian_flutter/src/view/loggycian_entry.dart';

class Loggycian extends StatefulWidget {
  const Loggycian({
    required this.app,
    required this.navigatorKey,
    this.visible = true,
    super.key,
  });
  final Widget app;
  final bool visible;
  final GlobalKey<NavigatorState> navigatorKey;

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
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => Stack(
              children: [
                widget.app,
                ValueListenableBuilder<bool>(
                  valueListenable: _showDebugButtonNotifier,
                  builder: (context, isVisible, _) {
                    if (!isVisible) return const SizedBox.shrink();
                    return LoggycianEntry(
                      visible: isVisible,
                      onPressed: () => widget.navigatorKey.currentState?.push(
                        MaterialPageRoute<void>(
                          builder: (context) => NetworkLoggerHomePage(
                            showDebugButtonNotifier: _showDebugButtonNotifier,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

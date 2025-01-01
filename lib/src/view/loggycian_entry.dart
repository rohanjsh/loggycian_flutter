import 'package:flutter/material.dart';
import 'package:loggycian_flutter/src/core/util/util.dart';

class LoggycianEntry extends StatefulWidget {
  const LoggycianEntry({
    required this.visible,
    required this.onPressed,
    super.key,
  });

  final bool visible;
  final VoidCallback onPressed;

  @override
  State<StatefulWidget> createState() => _LoggycianEntryState();
}

class _LoggycianEntryState extends State<LoggycianEntry> {
  Offset _offset = const Offset(20, 100);
  final _buttonWidth = 70.0;
  final _buttonHeight = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _offset = Offset(size.width - _buttonWidth, size.height / 2);
      });
    });
  }

  @override
  Widget build(BuildContext context) => Positioned(
        left: _offset.dx,
        top: _offset.dy,
        child: Draggable(
          feedback: _buildButton(),
          childWhenDragging: const SizedBox.shrink(),
          onDragEnd: (details) {
            setState(() {
              _offset = _clampPosition(details.offset, context);
            });
          },
          child: _buildButton(),
        ),
      );

  Widget _buildButton() => Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: _buttonWidth,
            height: _buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.red, width: 2),
              color: const Color(0xff1C1C1C),
            ),
            child: Center(
              child: Text(
                'loggycian',
                style: AppTextStyleConstants.body.copyWith(
                  color: Colors.limeAccent,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );

  Offset _clampPosition(Offset position, BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalCenter = size.width / 2;

    // Determine horizontal position (snap to left or right)
    final dx = position.dx < horizontalCenter ? 0.0 : size.width - _buttonWidth;

    // Clamp vertical position
    final dy = position.dy.clamp(
      _buttonHeight,
      size.height - _buttonHeight * 2,
    );

    return Offset(dx, dy);
  }
}

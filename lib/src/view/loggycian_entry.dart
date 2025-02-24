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
  State<LoggycianEntry> createState() => _LoggycianEntryState();
}

class _LoggycianEntryState extends State<LoggycianEntry> {
  Offset _offset = const Offset(20, 100);
  bool _isDragging = false;

  final _buttonWidth = 70.0;
  final _buttonHeight = 40.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      setState(() {
        _offset = Offset(size.width - _buttonWidth - 20, size.height / 2);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: _isDragging ? 0 : 300),
      curve: Curves.easeOutBack,
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onPanStart: (_) => _isDragging = true,
        onPanUpdate: (details) {
          setState(() {
            _offset += details.delta;
          });
        },
        onPanEnd: (_) {
          _isDragging = false;
          _snapToEdge(context);
        },
        child: _buildButton(),
      ),
    );
  }

  void _snapToEdge(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    setState(() {
      _offset = Offset(
        _offset.dx > screenWidth / 2 ? screenWidth - _buttonWidth - 20 : 20,
        _offset.dy.clamp(
          20,
          size.height - _buttonHeight - 20,
        ),
      );
    });
  }

  Widget _buildButton() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: _buttonWidth,
        height: _buttonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red, width: 2),
          color: const Color(0xff1C1C1C),
        ),
        child: InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(16),
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
  }
}

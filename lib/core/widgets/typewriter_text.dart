import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration duration;
  final Duration delay;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.duration = const Duration(milliseconds: 100),
    this.delay = const Duration(milliseconds: 500),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(
        milliseconds: widget.delay.inMilliseconds + 
                     (widget.text.length * widget.duration.inMilliseconds),
      ),
      vsync: this,
    );

    _animation = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _animation.addListener(() {
      setState(() {
        _displayText = widget.text.substring(0, _animation.value);
      });
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style,
      textAlign: widget.textAlign,
    );
  }
} 
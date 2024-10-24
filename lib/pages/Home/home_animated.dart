import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;
  final double borderRadius;

  const AnimatedButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.width,
    required this.height,
    required this.color,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        transform: isPressed
            ? Matrix4.translationValues(0, -5, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: isPressed ? widget.color.withOpacity(0.8) : widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: isPressed
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        width: widget.width,
        height: widget.height,
        child: widget.child,
      ),
    );
  }
}

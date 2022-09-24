import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double shrinkOffset;

  const BouncingButton(
      {Key key, this.onTap, this.child, this.shrinkOffset = 0.98})
      : super(key: key);

  @override
  _BouncingButtonState createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 70));
    _animation = Tween<double>(begin: 1.0, end: widget.shrinkOffset).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap != null) {
      return GestureDetector(
        onTapDown: (details) {
          _controller.forward(from: 0.0);
        },
        onTapUp: (details) {
          _controller.reverse();
          Future.delayed(const Duration(milliseconds: 50), () {
            widget.onTap();
          });
        },
        onTapCancel: () {
          _controller.reverse();
        },
        behavior: HitTestBehavior.translucent,
        child: ScaleTransition(
          scale: _animation,
          child: widget.child,
        ),
      );
    } else {
      return widget.child;
    }
  }
}

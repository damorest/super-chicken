import 'package:flutter/material.dart';

class GradientSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Gradient activeGradient;
  final Gradient inactiveGradient;
  final double width;
  final double height;
  final double padding;

  const GradientSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeGradient,
    required this.inactiveGradient,
    this.width = 50,
    this.height = 30,
    this.padding = 2,
  });

  @override
  State<GradientSwitch> createState() => _GradientSwitchState();
}

class _GradientSwitchState extends State<GradientSwitch> with SingleTickerProviderStateMixin {
  late bool isOn;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    isOn = widget.value;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: widget.width - widget.height).animate(_controller);
    if (isOn) _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(covariant GradientSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != isOn) {
      isOn = widget.value;
      if (isOn) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!isOn);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.all(widget.padding),
            decoration: BoxDecoration(
              gradient: isOn ? widget.activeGradient : widget.inactiveGradient,
              borderRadius: BorderRadius.circular(widget.height / 2),
            ),
            child: Align(
              alignment: Alignment(_animation.value / (widget.width - widget.height) * 2 - 1, 0),
              child: Container(
                width: widget.height - widget.padding * 2,
                height: widget.height - widget.padding * 2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


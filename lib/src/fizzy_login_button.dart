import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'bubble.dart';
import 'bubble_painter.dart';

class FizzyLoginButton extends StatefulWidget {
  final Future<void> Function()? onTap;

  final double width;
  final double height;

  final List<Color> gradientColors;
  final Color bubbleColor;
  final Color textColor;
  final String text;
  final String loadingText;

  const FizzyLoginButton({
    super.key,
    this.onTap,
    this.width = 220,
    this.height = 60,
    this.gradientColors = const [Colors.blue, Colors.cyan],
    this.bubbleColor = Colors.white,
    this.textColor = Colors.white,
    this.text = "Login",
    this.loadingText = "Logging in...",
  });

  @override
  State<FizzyLoginButton> createState() => _FizzyLoginButtonState();
}

class _FizzyLoginButtonState extends State<FizzyLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Bubble> bubbles = [];
  final Random random = Random();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(_updateBubbles);
  }

  void _generateBubbles() {
    for (int i = 0; i < 15; i++) {
      bubbles.add(Bubble(
        x: random.nextDouble(),
        y: 1,
        radius: random.nextDouble() * 6 + 2,
        speed: random.nextDouble() * 0.02 + 0.01,
        opacity: random.nextDouble(),
      ));
    }
  }

  void _updateBubbles() {
    setState(() {
      for (var b in bubbles) {
        b.y -= b.speed;
      }
      bubbles.removeWhere((b) => b.y < 0);
    });
  }

  Future<void> _handleTap() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
      _generateBubbles();
    });

    _controller.repeat();

    if (widget.onTap != null) {
      await widget.onTap!();
    } else {
      await Future.delayed(const Duration(seconds: 2));
    }

    _controller.stop();

    setState(() {
      bubbles.clear();
      isLoading = false;
    });
  }

  double get currentWidth => isLoading ? widget.height : widget.width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        width: currentWidth,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
          gradient: LinearGradient(colors: widget.gradientColors),
          boxShadow: [
            BoxShadow(
              color: widget.gradientColors.last.withOpacity(0.6),
              blurRadius: isLoading ? 20 : 8,
              spreadRadius: isLoading ? 4 : 1,
            )
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.height / 2),
              child: CustomPaint(
                painter: BubblePainter(bubbles, widget.bubbleColor),
                child: Container(),
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLoading
                  ? const SizedBox(
                      key: ValueKey("loader"),
                      width: 26,
                      height: 26,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      widget.text,
                      key: const ValueKey("text"),
                      style: TextStyle(
                        color: widget.textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            if (isLoading && currentWidth > widget.height + 20)
              Positioned(
                bottom: 6,
                child: Text(
                  widget.loadingText,
                  style: TextStyle(
                    color: widget.textColor.withOpacity(0.7),
                    fontSize: 10,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
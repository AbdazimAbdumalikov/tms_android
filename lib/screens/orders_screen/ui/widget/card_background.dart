import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 12),
    )..repeat(reverse: true);

    _animation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.white, end: Colors.lightBlue),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.lightBlue, end: Colors.lightGreen),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.lightGreen, end: Colors.pink),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.pink, end: Colors.orange),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.orange, end: Colors.purple),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.purple, end: Colors.yellow),
          weight: 1.0,
        ),
        // Добавьте больше цветов, если нужно
      ],
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _animation.value ?? Colors.transparent,
                Colors.white,
                _animation.value ?? Colors.transparent,
              ],
              stops: [0.1, 0.5, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15), // Измените отступы по вашему желанию
        child: Column(
          children: [
            // Добавьте сюда ваши виджеты для отображения на заднем фоне
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

import 'package:flutter/material.dart';

class AnimatedGradientDivider extends StatefulWidget {
  @override
  _AnimatedGradientDividerState createState() => _AnimatedGradientDividerState();
}

class _AnimatedGradientDividerState extends State<AnimatedGradientDivider>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    _animation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.transparent, end: Colors.blue),
          weight: 0.1,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue, end: Colors.green),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.green, end: Colors.red),
          weight: 1.0,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.red, end: Colors.transparent),
          weight: 0.1,
        ),
      ],
    ).animate(_controller);

    _widthAnimation = Tween<double>(
      begin: 200.0, // Изменено на 0.0
      end: 280.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.linear),
    ));

    // Запускаем анимацию изменения ширины с задержкой 4 секунды
    Future.delayed(Duration(seconds: 4), () {
      _controller.forward();
    });

    // Добавляем слушатель для бесконечного цикла анимации
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          height: 2,
          width: _widthAnimation.value,
          margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 75),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _animation.value ?? Colors.transparent,
                Color(0xFF979797),
                _animation.value ?? Colors.transparent,
              ],
              stops: [0.1, 0.5, 0.9],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

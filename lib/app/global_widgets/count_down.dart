import 'package:flutter/widgets.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({
    super.key,
    required this.title,
    required this.duration,
    this.style,
    this.onDone,
    this.onDoneWidget,
  });
  final Duration duration;
  final String title;
  final TextStyle? style;
  final Function()? onDone;
  final Widget? onDoneWidget;

  @override
  CountDownWidgetState createState() => CountDownWidgetState();
}

class CountDownWidgetState extends State<CountDownWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int get levelClock => widget.duration.inSeconds;

  @override
  void dispose() {
    _controller.removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget
          .duration, // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller.forward();
    _controller.addListener(listener);
  }

  void listener() {
    if (widget.onDone != null && _controller.isCompleted ||
        _controller.isDismissed) {
      widget.onDone!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _Countdown(
      style: widget.style,
      onDoneWidget: widget.onDoneWidget,
      animation: StepTween(
        begin: levelClock, // THIS IS A USER ENTERED NUMBER
        end: 0,
      ).animate(_controller),
    );
  }
}

class _Countdown extends AnimatedWidget {
  const _Countdown({required this.animation, this.style, this.onDoneWidget})
    : super(listenable: animation);
  final Animation<int> animation;
  final TextStyle? style;
  final Widget? onDoneWidget;
  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return (clockTimer.inSeconds == 0 && onDoneWidget != null)
        ? onDoneWidget!
        : Text(timerText, style: style);
  }
}

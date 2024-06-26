import 'package:flutter/widgets.dart';

class TwixAnimationBuilder extends StatefulWidget {
  const TwixAnimationBuilder({
    super.key,
    required this.duration,
    required this.builder,
  });

  final Duration duration;
  final Widget Function(BuildContext context, AnimationController controller) builder;

  @override
  State<TwixAnimationBuilder> createState() => _TwixAnimationBuilderState();
}

class _TwixAnimationBuilderState extends State<TwixAnimationBuilder> with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return widget.builder(context, controller);
      },
    );
  }
}

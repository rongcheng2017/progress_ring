import 'package:flutter/material.dart';

import 'progress_ring_painter.dart';

class ProgressRing extends StatefulWidget {
  final Size size;
  final Duration duration;
  //value from 0.00~1.00
  final double value;
  //进度条的宽度
  final double strokeW;
  //圆框颜色
  final Color circularRingColor;
  //进度条的颜色
  final Color progressColor;

  final TextStyle? textStyle;
  //替换百分比 自定义显示文案
  final Text? text;
  //进度条StrokeCap类型 默认是round.当value<=0 改为butt
  final StrokeCap? strokeCap;

  final ProgressController? progerssController;

  // final TextDecoration textDecoration;
  const ProgressRing(
      {Key? key,
      required this.value,
      required this.size,
      this.duration = const Duration(seconds: 2),
      this.strokeW = 10,
      this.textStyle,
      this.strokeCap,
      this.text,
      this.progerssController,
      this.circularRingColor = Colors.black38,
      this.progressColor = Colors.pinkAccent})
      : super(key: key);

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    if (widget.value > 0) controller.animateTo(widget.value);
    widget.progerssController?.setAnimationController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      child: SizedBox(
        width: widget.size.width,
        height: widget.size.height,
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (BuildContext context, double value, Widget? child) {
              return buildText(context, value, widget.text);
            },
          ),
        ),
      ),
      painter: ProgressRingPainter(
          size: widget.size,
          progress: controller,
          circularRingColor: widget.circularRingColor,
          progressColor: widget.progressColor,
          strokeCap: widget.value <= 0
              ? StrokeCap.butt
              : widget.strokeCap ?? StrokeCap.round,
          strokeW: widget.strokeW),
    );
  }

  Widget buildText(BuildContext context, double value, Widget? child) {
    return child ??
        Text(
          "${(value * 100).toInt()}%",
          style: widget.textStyle,
        );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ProgressController {
  AnimationController? animationController;

  setAnimationController(AnimationController controller) {
    animationController = controller;
  }

  update(double value) {
    animationController?.animateTo(value);
  }
}

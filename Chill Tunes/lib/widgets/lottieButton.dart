import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieButton extends StatefulWidget {
  final String path;
  final double width;
  final double height;
  final double start;
  final double end;
  final double? initialPosition;
  final void Function(bool) onTap;

  const LottieButton(
      {Key? key,
      required this.start,
      required this.end,
      required this.onTap,
      required this.path,
      this.initialPosition,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  LottieButtonState createState() => LottieButtonState();
}

class LottieButtonState extends State<LottieButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Lottie.asset(
        widget.path,
        width: widget.width,
        height: widget.height,
        controller: controller,
        onLoaded: (composition) {
          setState(() {
            controller.duration = composition.duration;

            if (widget.initialPosition != null) {
              controller.animateTo(
                widget.initialPosition!,
              );
            }
          });
        },
      ),
      onTap: _onTap,
    );
  }

  void _onTap() {
    widget.onTap(isPlaying);
    print(
        "LOTTIE TAPPED  ${widget.initialPosition}  ${widget.start}  ${widget.end} ${!isPlaying}");
    isPlaying = !isPlaying;
    controller.animateTo(
      isPlaying ? widget.start : widget.end,
      duration: Duration(milliseconds: 850),
    );
  }

  void onPlay() {
    isPlaying = !isPlaying;
    controller.animateTo(
      isPlaying ? widget.start : widget.end,
      duration: Duration(milliseconds: 850),
    );
  }
}

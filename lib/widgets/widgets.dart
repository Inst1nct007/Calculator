import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import '../providers/mathprovider.dart';

class ButtonWidget extends StatefulWidget {
  final String buttonText;
  const ButtonWidget({Key? key, required this.buttonText}) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> with SingleTickerProviderStateMixin{
  late AnimationController animationController;
  late Animation animationTween;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 30));
    animationTween = Tween(begin: 1, end: 1.1).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final math = Provider.of<Math>(context);
    return AnimatedBuilder(
        animation: animationController.view,
        builder: (context, child){
          return Transform.scale(
            scale: animationTween.value.toDouble(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
              child: GestureDetector(
                onTap: () async {
                  animationTween = Tween(begin: 1, end: 1.1).animate(animationController);
                  animationController.forward();
                  await Future.delayed(Duration(milliseconds: 40));
                  math.updateExpression(context, widget.buttonText);
                  animationController.reverse();
                },
                onLongPress: () async {
                  HapticFeedback.heavyImpact();
                  animationTween = Tween(begin: 1, end: 1.15).animate(animationController);
                  animationController.forward();
                  await Future.delayed(Duration(milliseconds: 70));
                  math.updateExpressionLongPressed(widget.buttonText);
                  animationController.reverse();
                },
                child: GlassContainer(
                  height: MediaQuery.of(context).size.height / math.widgetHeight,
                  width: MediaQuery.of(context).size.width / math.widgetWidth,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.40),
                      Colors.white70.withOpacity(0.10),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderColor: Colors.white70,
                  blur: 20,
                  borderRadius: BorderRadius.circular(10),
                  borderWidth: 0.5,
                  elevation: animationTween.value.toDouble(),
                  isFrostedGlass: false,
                  shadowColor: Colors.red.withOpacity(0.20),
                  child: Center(child: Text(widget.buttonText, style: TextStyle(color: Colors.blueAccent, fontSize: math.fontSize, fontWeight: FontWeight.bold),)),
                ),
              ),
            ),
          );
        },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gtext_widget.dart';

class CardMateria extends StatefulWidget {
  final String id;
  final String? backgroundAsset;
  final String? title;
  final int totalLessons;
  final int doneLessons;
  final VoidCallback onTap;

  const CardMateria({
    Key? key,
    required this.id,
    required this.totalLessons,
    required this.onTap,
    this.backgroundAsset,
    this.title,
    this.doneLessons = 0,
  }) : super(key: key);

  @override
  _CardMateriaState createState() => _CardMateriaState();
}

class _CardMateriaState extends State<CardMateria>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation tween;
  late int remainingLessons;
  late double percentRemaininLessons;

  @override
  initState() {
    super.initState();
    percentRemaininLessons = widget.doneLessons / widget.totalLessons;

    _controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    tween = Tween<double>(begin: 0.0, end: percentRemaininLessons)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    tween.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CardMateria oldWidget) {
    super.didUpdateWidget(oldWidget);

    percentRemaininLessons = widget.doneLessons / widget.totalLessons;
    if (percentRemaininLessons > 1) {
      percentRemaininLessons = 1;
    }

    var oldPercent = oldWidget.doneLessons / oldWidget.totalLessons;

    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    tween = Tween<double>(begin: oldPercent, end: percentRemaininLessons)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));

    tween.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    remainingLessons = widget.totalLessons - widget.doneLessons;

    return Material(
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 2),
              )
            ]),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SvgPicture.asset(
                widget.backgroundAsset ?? "",
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: 17,
                  left: 15,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color.fromRGBO(0, 0, 0, 0.43)),
                          value: tween.value,
                          strokeWidth: 8.3,
                        ),
                      ),
                      GText(
                        "${(percentRemaininLessons * 100).toInt()}%",
                        color: Colors.white,
                        fontSize: 12,
                      )
                    ],
                  )),
              Positioned(
                  bottom: 17,
                  left: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GText(widget.title ?? "",
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          italic: FontStyle.italic),
                      SizedBox(
                        height: 5,
                      ),
                      GText(
                          (remainingLessons < 1)
                              ? "Aulas completas"
                              : "$remainingLessons aulas restantes",
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

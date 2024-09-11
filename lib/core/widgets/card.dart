import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double? radius;
  const CardWidget(
      {super.key,
      required this.child,
      required this.height,
      required this.width,
      this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius??4.0),
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: .2, color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: .5,
            blurRadius: .1,
            offset: const Offset(0, .5), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }
}

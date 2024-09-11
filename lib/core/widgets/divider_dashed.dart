import 'package:flutter/material.dart';

class DividerDashed extends StatelessWidget {
  const DividerDashed({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        150 ~/ 1,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.grey,
            height: .5,
          ),
        ),
      ),
    );
  }
}

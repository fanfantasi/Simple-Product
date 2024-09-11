import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  const ShimmerWidget({Key? key, this.width, this.height, this.radius, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? MediaQuery.of(context).size.width / 4,
      child: Shimmer.fromColors(
        baseColor: color?.withOpacity(.5) ?? Colors.red.shade50.withOpacity(.5),
        highlightColor: color?.withOpacity(.1) ??Colors.red.shade50.withOpacity(.1),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius ?? 6.0)),
        ),
      ),
    );
  }
}

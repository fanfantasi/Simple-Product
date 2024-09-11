
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUtils {
  static Widget shimmer(
    BuildContext context,
  ) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade50,
        child: Container(
          color: Colors.grey,
          height: kToolbarHeight * 4.8,
        )
      ),
    );
  }
}

class ShimmerAvatar {
  static Widget shimmer(
    BuildContext context,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: kToolbarHeight,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/png/logo.png'),
            radius: kToolbarHeight * .9,
          ),
        ),
        const SizedBox(height: 4,),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: 16,
            width: kToolbarHeight * 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.shade400,
            ),
            
          )
        ),
        const SizedBox(height: 4.0,),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: 16,
            width: kToolbarHeight * 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey.shade400,
            ),
            
          )
        ),
      ],
    );
  }
}

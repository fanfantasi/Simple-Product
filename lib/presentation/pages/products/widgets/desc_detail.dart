import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class DescWidget extends StatefulWidget {
  final String? desc;
  const DescWidget({super.key, this.desc});

  @override
  State<DescWidget> createState() => _DescWidgetState();
}

class _DescWidgetState extends State<DescWidget> with SingleTickerProviderStateMixin{
  bool isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;
  
  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _animation =
        Tween(begin: 0.0, end: .5).animate(CurvedAnimation(
        parent: _controller, curve: Curves.easeOut));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: !isExpanded ? const BoxConstraints(
        maxHeight: 250
      ):null,
      child: Stack(
        children: [
          Padding(
            padding: isExpanded ? const  EdgeInsets.only(bottom: 42) : const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Html(data: widget.desc ?? ''),
            ),
          ),
          Positioned(
            bottom: -10,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
                setState(() {
                  isExpanded = !isExpanded;
                });
                
              },
              child: Container(
                  height: kToolbarHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.white.withOpacity(1),
                        Colors.white.withOpacity(.8),
                      ],
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          RotationTransition(
                            turns: _animation,
                            child: const Icon(Icons.keyboard_arrow_down_rounded)),
                          Text(isExpanded ? 'Up' : 'Down')
                        ],
                      ))),
            ),
          )
        ],
      ),
    );
  }
}

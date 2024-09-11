import 'package:flutter/material.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((v) async {
      Future.delayed(const Duration(milliseconds: 300), () async {
        Navigator.pushNamed(context, '/product');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Align(
        alignment: Alignment.center,
        child: FlutterLogo(
          size: kToolbarHeight * 2,
          textColor: Colors.blue,
          style: FlutterLogoStyle.stacked,
        ),
      ),
    );
  }
}
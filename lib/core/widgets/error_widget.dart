import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorWidgetMessage extends StatelessWidget {
  final String errorMessage;
  const ErrorWidgetMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          centerTitle: true,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Error'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 22.0,),
          const Icon(Icons.error, size: 24,),
          Center(
            child: Text(
              kDebugMode
              ? errorMessage.toString()
              : 'Oops... Something Went Wrong!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background
              ),
            ),
          )
        ],
      ),
    );
  }
}
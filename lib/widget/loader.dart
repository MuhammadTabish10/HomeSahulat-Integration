import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final bool isLoading;

  const LoaderWidget({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      child: AnimatedOpacity(
        opacity: isLoading ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

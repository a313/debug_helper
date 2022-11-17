import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.floatingActionButton});
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: body,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableTitle extends StatelessWidget {
  const CopyableTitle({
    Key? key,
    required this.title,
    this.maxLine = 4,
    this.overflow,
  }) : super(key: key);

  final String title;
  final int? maxLine;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: title));
        showToast(context, msg: 'Copied');
      },
      child: Text(
        title,
        maxLines: maxLine,
        overflow: overflow,
      ),
    );
  }

  void showToast(BuildContext context, {required String msg}) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

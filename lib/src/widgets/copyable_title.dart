import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableContent extends StatelessWidget {
  const CopyableContent({
    Key? key,
    required this.content,
    this.maxLine,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);

  final String content;
  final int? maxLine;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: content));
        showToast(context, msg: 'Copied');
      },
      child: Text(
        content,
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

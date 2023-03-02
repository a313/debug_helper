import 'package:debug_helper/src/widgets/copyable_title.dart';
import 'package:flutter/material.dart';

class CollapseSection extends StatefulWidget {
  const CollapseSection({
    super.key,
    required this.title,
    required this.content,
    this.defaultCollapse = true,
  });
  final String title;
  final String content;
  final bool defaultCollapse;

  @override
  State<CollapseSection> createState() => _CollapseSectionState();
}

class _CollapseSectionState extends State<CollapseSection> {
  late bool isCollapse;

  @override
  void initState() {
    isCollapse = widget.defaultCollapse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(widget.title)),
            const SizedBox(
              width: 8,
            ),
            IconButton(
                onPressed: onToggle,
                icon: isCollapse
                    ? const Icon(Icons.arrow_circle_down_sharp)
                    : const Icon(Icons.arrow_circle_up_sharp))
          ],
        ),
        CopyableContent(
          content: widget.content,
          maxLine: isCollapse ? 4 : null,
        ),
      ],
    );
  }

  void onToggle() {
    setState(() {
      isCollapse = !isCollapse;
    });
  }
}

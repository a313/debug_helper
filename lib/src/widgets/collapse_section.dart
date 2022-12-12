import 'package:debug_helper/src/widgets/copyable_title.dart';
import 'package:flutter/material.dart';

class CollapseSection extends StatefulWidget {
  const CollapseSection(
      {super.key, required this.title, required this.content});
  final String title;
  final String content;

  @override
  State<CollapseSection> createState() => _CollapseSectionState();
}

class _CollapseSectionState extends State<CollapseSection> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(widget.title)),
            const SizedBox(
              width: 8,
            ),
            IconButton(
                onPressed: onToggle,
                icon: isExpanded
                    ? const Icon(Icons.arrow_circle_up_sharp)
                    : const Icon(Icons.arrow_circle_down_sharp))
          ],
        ),
        CopyableContent(
          content: widget.content,
          maxLine: isExpanded ? null : 4,
        ),
      ],
    );
  }

  void onToggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

import 'package:debug_helper/src/debug_helper.dart';
import 'package:debug_helper/src/extentions.dart';
import 'package:flutter/material.dart';

import '../model/exception_data.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/copyable_title.dart';

class ExceptionScene extends StatefulWidget {
  const ExceptionScene({Key? key}) : super(key: key);

  @override
  State createState() => _ExceptionSceneState();
}

class _ExceptionSceneState extends State<ExceptionScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().exceptions.reversed;

    return BaseScaffold(
      title: "Exception Log",
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.clear_all),
          onPressed: () {
            setState(() {
              DebugHelper.clearException();
            });
          }),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final d = data.elementAt(index);
            return ListTile(
              dense: true,
              title: CopyableContent(
                content: d.error.toString(),
              ),
              onTap: () => context.to(_DetailPage(data: d)),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: data.length),
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ExceptionData data;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Stack Trace",
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: CopyableContent(
            content: data.stack.toString(),
          ),
        ),
      ),
    );
  }
}

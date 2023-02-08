import 'package:debug_helper/src/debug_helper.dart';
import 'package:debug_helper/src/extentions.dart';
import 'package:debug_helper/src/model/fcm_data.dart';
import 'package:flutter/material.dart';

import '../widgets/base_scaffold.dart';
import '../widgets/copyable_title.dart';

class FcmPage extends StatefulWidget {
  const FcmPage({Key? key}) : super(key: key);

  @override
  State createState() => _FcmPageState();
}

class _FcmPageState extends State<FcmPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().notis.reversed;

    return BaseScaffold(
      title: "Fcm Log",
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.clear_all),
          onPressed: () {
            setState(() {
              DebugHelper.clearNotis();
            });
          }),
      body: ListView.separated(
          itemBuilder: (context, index) {
            final d = data.elementAt(index);
            return ListTile(
              dense: true,
              title: CopyableContent(
                content: d.map['messageId'].toString(),
              ),
              subtitle: Text(d.type.name),
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
  final FCMData data;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Fcm Detail",
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: CopyableContent(
            content: data.map.toString(),
          ),
        ),
      ),
    );
  }
}

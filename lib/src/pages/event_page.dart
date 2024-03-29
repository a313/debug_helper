import 'package:debug_helper/src/debug_helper.dart';
import 'package:debug_helper/src/extentions.dart';
import 'package:debug_helper/src/widgets/copyable_title.dart';
import 'package:flutter/material.dart';

import '../model/event_data.dart';
import '../widgets/base_scaffold.dart';

class EventTrackingScene extends StatefulWidget {
  const EventTrackingScene({Key? key}) : super(key: key);

  @override
  State createState() => _EventTrackingSceneState();
}

class _EventTrackingSceneState extends State<EventTrackingScene> {
  String subKey = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().events.reversed;

    return BaseScaffold(
      title: "Event Log",
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.clear_all),
          onPressed: () {
            setState(() {
              DebugHelper.clearEvent();
            });
          }),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter param key to show on subtitle',
              ),
              onChanged: (value) => setState(() {
                subKey = value;
              }),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final d = data.elementAt(index);
                  return ListTile(
                    dense: true,
                    title: CopyableContent(
                      content: d.name,
                    ),
                    subtitle: Text(d.params[subKey].toString()),
                    onTap: () => context.to(_DetailPage(data: d)),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: data.length),
          ),
        ],
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final EventData data;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Detail",
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CopyableContent(
            content: formatListOrMap(data.params),
          ),
        ),
      ),
    );
  }
}

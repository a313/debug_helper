import 'package:debug_helper/src/extentions.dart';
import 'package:flutter/material.dart';

import '../widgets/base_scaffold.dart';
import 'api_log_page.dart';
import 'event_page.dart';
import 'exception_page.dart';

class DebugCatalogPage extends StatelessWidget {
  const DebugCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Category',
      body: ListView(
        children: [
          ListTile(
            title: const Text('Api Log'),
            onTap: () => context.to(const ApiLogScene()),
          ),
          const Divider(),
          ListTile(
            title: const Text('Event Tracking'),
            onTap: () => context.to(const EventTrackingScene()),
          ),
          const Divider(),
          ListTile(
            title: const Text('App Exception'),
            onTap: () => context.to(const ExceptionScene()),
          ),
        ],
      ),
    );
  }
}

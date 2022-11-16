import 'package:debug_helper/src/extentions.dart';
import 'package:flutter/material.dart';

import 'pages/api_log_page.dart';
import 'pages/event_page.dart';

class DebugCatalogPage extends StatelessWidget {
  const DebugCatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
        ),
      ),
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
          const ListTile(
            title: Text('App Exception'),
            // onTap: () => Get.to(() => const ExceptionScene()),
          ),
        ],
      ),
    );
  }
}

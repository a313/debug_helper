import 'package:debug_helper/src/extentions.dart';
import 'package:debug_helper/src/pages/fcm_log_page.dart';
import 'package:debug_helper/src/pages/http_code_explain.dart';
import 'package:flutter/material.dart';

import '../debug_helper.dart';
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
          _Item(
            title: 'Api Log',
            onTap: () => context.to(const ApiLogScene()),
          ),
          const Divider(),
          _Item(
            title: 'Event Tracking',
            onTap: () => context.to(const EventTrackingScene()),
          ),
          const Divider(),
          _Item(
            title: 'App Exception',
            badge: getExcBadge(),
            onTap: () => context.to(const ExceptionScene()),
          ),
          const Divider(),
          _Item(
            title: 'Fcm Log',
            badge: getFcmBadge(),
            onTap: () => context.to(const FcmPage()),
          ),
          const Divider(),
          _Item(
            title: 'Http Status Code Explain',
            onTap: () => context.to(const HttpCodeExplain()),
          ),
        ],
      ),
    );
  }

  String? getExcBadge() {
    final length = DebugHelper.getInstance().exceptions.length;
    return length > 0 ? length.toString() : null;
  }

  String? getFcmBadge() {
    final length = DebugHelper.getInstance().notis.length;
    return length > 0 ? length.toString() : null;
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.onTap, this.badge});

  final String title;
  final String? badge;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: badge != null
          ? Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.redAccent),
              padding: const EdgeInsets.all(8),
              child: Text(
                badge ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

import 'package:debug_helper/src/debug_helper.dart';
import 'package:debug_helper/src/extentions.dart';
import 'package:debug_helper/src/widgets/collapse_section.dart';
import 'package:flutter/material.dart';

import '../model/api_data.dart';
import '../widgets/base_scaffold.dart';
import '../widgets/copyable_title.dart';

class ApiLogScene extends StatefulWidget {
  const ApiLogScene({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ApiLogSceneState();
  }
}

class _ApiLogSceneState extends State<ApiLogScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Api Log",
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.clear_all),
          onPressed: () {
            setState(() {
              DebugHelper.clearApi();
            });
          }),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SizedBox(
                height: 50.0,
                child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: "Succesfull"),
                      Tab(text: "Failed"),
                    ])),
          ),
          body: TabBarView(children: [
            _SuccessPage(key: UniqueKey()),
            _ExceptionPage(key: UniqueKey()),
          ]),
        ),
      ),
    );
  }
}

class _ExceptionPage extends StatelessWidget {
  const _ExceptionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().apiFailed.reversed;

    return ListView.separated(
        itemBuilder: (context, index) => _Cell(data: data.elementAt(index)),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length);
  }
}

class _SuccessPage extends StatelessWidget {
  const _SuccessPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().apiSuccess.reversed;
    return ListView.separated(
        itemBuilder: (context, index) => _Cell(data: data.elementAt(index)),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.length);
  }
}

class _DetailPage extends StatelessWidget {
  const _DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final ApiData data;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontSize: 12),
      child: BaseScaffold(
        title: "Detail",
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                  'Request At: ${data.requestDate.toStringFormat('HH:mm:ss')}'),
              CopyableContent(content: "${data.method} : ${data.url}"),
              const Divider(),
              CollapseSection(
                title: 'Header',
                content: formatListOrMap(data.header),
              ),
              const Divider(),
              // CopyableContent(content: "Params\n${data.params}"),
              CollapseSection(
                title: 'Params',
                defaultCollapse: false,
                content: formatListOrMap(data.params),
              ),
              const Divider(),
              Visibility(
                visible: data.response != null,
                child: CollapseSection(
                  title: 'Response',
                  defaultCollapse: false,
                  content: formatListOrMap(data.response),
                ),
              ),
              Visibility(
                visible: data.extraData != null,
                child: CollapseSection(
                  title: 'Extra',
                  defaultCollapse: false,
                  content: data.extraData.toString(),
                ),
              ),
              Visibility(
                visible: data.exception != null,
                child: _Exception(
                  exception: data.exception,
                  bodyString: data.bodyString,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Exception extends StatelessWidget {
  final String? exception;
  final String? bodyString;

  const _Exception({Key? key, this.exception, this.bodyString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CollapseSection(
          title: 'Exception',
          content: exception ?? "null",
          defaultCollapse: false,
        ),
        CollapseSection(
          title: 'Body',
          content: bodyString ?? "null",
        )
      ],
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ApiData data;

  @override
  Widget build(BuildContext context) {
    final responseTime = data.responseTime ?? -1;

    Color color = Colors.green;
    if (responseTime >= 1000) {
      color = Colors.red;
    } else if (responseTime >= 500) {
      color = const Color(0xFFF9A825);
    }

    return ListTile(
        title: CopyableContent(
          content: data.url,
        ),
        subtitle: Text.rich(
          TextSpan(
              text:
                  'Request At: ${data.requestDate.toStringFormat('HH:mm:ss')}',
              children: responseTime >= 0
                  ? [
                      const TextSpan(text: '\nResponse Time: '),
                      TextSpan(
                          text: "$responseTime" "ms",
                          style: TextStyle(color: color))
                    ]
                  : null),
        ),
        onTap: () => context.to(_DetailPage(data: data)));
  }
}

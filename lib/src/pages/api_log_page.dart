import 'dart:convert';

import 'package:debug_helper/src/debug_helper.dart';
import 'package:debug_helper/src/extentions.dart';
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
            _SuccessPage(
              key: UniqueKey(),
            ),
            _ExceptionPage(
              key: UniqueKey(),
            ),
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

class _Cell extends StatelessWidget {
  const _Cell({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ApiData data;

  @override
  Widget build(BuildContext context) {
    final responseTime = data.responseTime ?? -1;

    var color = Colors.grey;
    if (responseTime > 500) {
      color = Colors.amber;
    } else if (responseTime > 1000) {
      color = Colors.red;
    }
    return ListTile(
        title: CopyableTitle(
          title: data.url,
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

class _SuccessPage extends StatelessWidget {
  const _SuccessPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().apiSuccess.reversed;
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              title: CopyableTitle(title: data.elementAt(index).url),
              subtitle: Text(
                  'Request At: ${data.elementAt(index).requestDate.toStringFormat('HH:mm:ss')}\nResponse Time: ${data.elementAt(index).responseTime}ms'),
              onTap: () => context.to(_DetailPage(data: data.elementAt(index))),
            ),
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
              CopyableTitle(title: "${data.method} : ${data.url}"),
              const Divider(),
              CopyableTitle(
                title: "Header:\n${data.header}",
                maxLine: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Divider(),
              CopyableTitle(
                title: "Params:\n${data.params}",
                maxLine: 4,
              ),
              const Divider(),
              Visibility(
                visible: data.response != null,
                child: _Response(
                  response: data.response,
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

class _Response extends StatelessWidget {
  final dynamic response;

  const _Response({Key? key, this.response}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Response:"),
        CopyableTitle(
          title: encoder.convert(response),
          maxLine: null,
        ),
      ],
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
        const Text("Exception:"),
        CopyableTitle(
          title: exception ?? "null",
          maxLine: null,
        ),
        const Text("body:"),
        CopyableTitle(
          title: bodyString ?? "null",
          maxLine: null,
        ),
      ],
    );
  }
}

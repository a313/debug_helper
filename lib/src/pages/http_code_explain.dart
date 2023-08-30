import 'package:debug_helper/src/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class HttpCodeExplain extends StatelessWidget {
  const HttpCodeExplain({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Status Code Explain",
      body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => Text(
              '${mapStatusCode.keys.elementAt(index)} => ${mapStatusCode.values.elementAt(index)}'),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: mapStatusCode.length),
    );
  }
}

const mapStatusCode = {
  100: 'continue_',
  101: 'switchingProtocols',
  102: 'processing',
  103: 'earlyHints',
  200: 'ok',
  201: 'created',
  202: 'accepted',
  203: 'nonAuthoritativeInformation',
  204: 'noContent',
  205: 'resetContent',
  206: 'partialContent',
  207: 'multiStatus',
  208: 'alreadyReported',
  226: 'imUsed',
  300: 'multipleChoices',
  301: 'movedPermanently',
  302: 'movedTemporarily',
  303: 'seeOther',
  304: 'notModified',
  305: 'useProxy',
  306: 'switchProxy',
  307: 'temporaryRedirect',
  308: 'permanentRedirect',
  400: 'badRequest',
  401: 'unauthorized',
  402: 'paymentRequired',
  403: 'forbidden',
  404: 'notFound',
  405: 'methodNotAllowed',
  406: 'notAcceptable',
  407: 'proxyAuthenticationRequired',
  408: 'requestTimeout',
  409: 'conflict',
  410: 'gone',
  411: 'lengthRequired',
  412: 'preconditionFailed',
  413: 'requestEntityTooLarge',
  414: 'requestUriTooLong',
  415: 'unsupportedMediaType',
  416: 'requestedRangeNotSatisfiable',
  417: 'expectationFailed',
  418: 'imATeapot',
  421: 'misdirectedRequest',
  422: 'unprocessableEntity',
  423: 'locked',
  424: 'failedDependency',
  425: 'tooEarly',
  426: 'upgradeRequired',
  428: 'preconditionRequired',
  429: 'tooManyRequests',
  431: 'requestHeaderFieldsTooLarge',
  444: 'connectionClosedWithoutResponse',
  451: 'unavailableForLegalReasons',
  499: 'clientClosedRequest',
  500: 'internalServerError',
  501: 'notImplemented',
  502: 'badGateway',
  503: 'serviceUnavailable',
  504: 'gatewayTimeout',
  505: 'httpVersionNotSupported',
  506: 'variantAlsoNegotiates',
  507: 'insufficientStorage',
  508: 'loopDetected',
  510: 'notExtended',
  511: 'networkAuthenticationRequired',
  599: 'networkConnectTimeoutError',
};

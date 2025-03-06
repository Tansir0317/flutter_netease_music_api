import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_netease_music_api/flutter_netease_music_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _startServer(port: 3001);
}

Future<HttpServer> _startServer({address = "localhost", int port = 3000}) {
  return HttpServer.bind(address, port, shared: true).then((server) {
    print("start listen at: http://$address:$port");
    server.listen((request) {
      _handleRequest(request);
    });
    return server;
  });
}

void _handleRequest(HttpRequest request) async {
  if (request.uri.path == '/favicon.ico') {
    request.response.statusCode = 404;
    request.response.close();
    return;
  }
  final answer = await cloudMusicApi(request.uri.path, parameter: request.uri.queryParameters, cookie: request.cookies).catchError((e, s) async {
    print(e.toString());
    print(s.toString());
    return const Answer();
  });

  request.response.statusCode = answer.status;
  request.response.cookies.addAll(answer.cookie);
  request.response.write(json.encode(answer.body));
  request.response.close();

  print("request[${answer.status}] : ${request.uri}");
}

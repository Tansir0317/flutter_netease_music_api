import 'package:flutter/material.dart';
import 'package:flutter_netease_music_api/flutter_netease_music_api.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NeteaseMusicApi.init(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('flutter_netease_music_api')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton(onPressed: () async {
              final res = await NeteaseMusicApi().playlistHotTags();
              print("res---${res.toJson()}");
            }, child: Text("发送请求"))
            ],
          ),
        ),
      ),
    );
  }
}
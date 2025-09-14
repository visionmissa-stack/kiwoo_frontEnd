import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  final MyInAppBrowser browser = MyInAppBrowser();

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var options = InAppBrowserClassSettings(
    browserSettings: InAppBrowserSettings(hideUrlBar: false),
    webViewSettings: InAppWebViewSettings(javaScriptEnabled: true),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InAppBrowser Example'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              widget.browser.openUrlRequest(
                urlRequest: URLRequest(url: WebUri("https://flutter.dev")),
                settings: options,
              );
            },
            child: Text("Open InAppBrowser")),
      ),
    );
  }
}

import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VitaminWebView extends StatefulWidget {
  @override
  _VitaminWebViewState createState() => _VitaminWebViewState();
}

class _VitaminWebViewState extends State<VitaminWebView> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  late WebViewController controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  DateTime prebackpress = DateTime.now();
  Future<bool> _onWillPop(BuildContext context) async {
    print("--------------------------------------------------------");

    prebackpress = DateTime.now();

    if (await controller.canGoBack()) {
      print("true");
      controller.goBack();
      return Future.value(false);
    } else {
      print("false");
      // AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.WARNING,
      //   animType: AnimType.BOTTOMSLIDE,
      //   headerAnimationLoop: false,
      //   title: "Exit",
      //   desc: "Are you sure you want to exit?",
      //   btnCancelText: "No",
      //   btnOkText: "Yes",
      //   btnCancelColor: Color(0xffc5c5c9),
      //   btnCancelOnPress: () {
      //     return;
      //   },
      //   btnOkOnPress: () {

      //   },
      // )..show();
      Navigator.pop(context);
      return Future.value(false);
      // return Future.value(true);
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            child: WebView(
              initialUrl:
                  "https://www.amazon.com/Best-Sellers-Dog-Multivitamins/zgbs/pet-supplies/3024221011",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController c) {
                _controllerCompleter.future.then((value) => controller = value);
                _controllerCompleter.complete(c);
              },
              navigationDelegate: (NavigationRequest request) {
                print(request.url);
                if (request.url.contains('whatsapp:') ||
                    (request.url.contains('tel:'))) {
                  launch(request.url);
                  return NavigationDecision.prevent;
                } else {
                  return NavigationDecision.navigate;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

















































  /*  prebackpress = DateTime.now();
 DateTime prebackpress = DateTime.now();
    final timegap = DateTime.now().difference(prebackpress);

    final cantExit = timegap >= Duration(seconds: 2);
      if (cantExit) {

        //show snackbar
        final snack = SnackBar(
          content: Text('Press Back button again to Exit'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        return false;
      } else {
        return true;
      } */


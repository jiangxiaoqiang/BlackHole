import 'package:blackhole/CustomWidgets/gradientContainers.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String appVersion;

  @override
  void initState() {
    main();
    super.initState();
  }

  void main() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.of(context).size.width / 2,
            top: MediaQuery.of(context).size.width / 5,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/icon-white-trans.png',
                ),
              ),
            ),
          ),
          GradientContainer(
            child: null,
            opacity: true,
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.transparent
                  : Theme.of(context).accentColor,
              elevation: 0,
              title: Text(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: 150,
                        child:
                            Image(image: AssetImage('assets/ic_launcher.png'))),
                    SizedBox(height: 20),
                    Text(
                      'BlackHole',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text('v$appVersion'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: Column(
                    children: [
                      Text(
                        'This is an open-source project and can be found on',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: Image(
                              image: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AssetImage('assets/GitHub_Logo_White.png')
                                  : AssetImage('assets/GitHub_Logo.png'),
                            ),
                          ),
                          onPressed: () {
                            launch("https://github.com/Sangwan5688/BlackHole");
                          }),
                      Text(
                        "If you liked my work\nshow some ♥ and ⭐ the repo",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        primary: Colors.transparent,
                      ),
                      child: Container(
                        child: Image(
                          image: AssetImage('assets/black-button.png'),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      onPressed: () {
                        launch("https://www.buymeacoffee.com/ankitsangwan");
                      },
                    ),
                    Text(
                      "OR",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        primary: Colors.transparent,
                      ),
                      child: Container(
                        child: Image(
                          image: AssetImage(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 'assets/gpay-white.png'
                                  : 'assets/gpay-white.png'),
                        ),
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      onPressed: () {
                        final userId = Hive.box('settings').get('userId');
                        String upiUrl =
                            'upi://pay?pa=8570094149@okbizaxis&pn=Ankit%20Sangwan&mc=5732&aid=uGICAgIDn98OpSw&tr=BCR2DN6T37O6DB3Q&tn=$userId';
                        launch(upiUrl);
                      },
                    ),
                    Text(
                      "Sponsor this project",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                  child: Center(
                    child: Text(
                      'Made with ♥ by Ankit Sangwan',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

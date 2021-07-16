import 'dart:io';
import 'package:audiotagger/audiotagger.dart';
import 'package:audiotagger/models/tag.dart';
<<<<<<< HEAD
=======
import 'package:blackhole/Helpers/lyrics.dart';
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Download with ChangeNotifier {
  String preferredDownloadQuality =
      Hive.box('settings').get('downloadQuality') ?? '320 kbps';
  double progress = 0.0;
  String currentDownloadId = '';
  String lastDownloadId = '';
  String dlPath = Hive.box('settings').get('downloadPath', defaultValue: '');
<<<<<<< HEAD
=======
  bool downloadLyrics =
      Hive.box('settings').get('downloadLyrics', defaultValue: false);

  Future<String> getLyrics(Map data) async {
    if (data["has_lyrics"] == "true") {
      return Lyrics().getSaavnLyrics(data["id"]);
    } else {
      return Lyrics()
          .getLyrics(data['title'].toString(), data['artist'].toString());
    }
  }
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e

  Future<void> prepareDownload(BuildContext context, Map data) async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isPermanentlyDenied || status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.accessMediaLocation,
        Permission.mediaLibrary,
      ].request();
      debugPrint(statuses[Permission.storage].toString());
    }
    status = await Permission.storage.status;
    if (status.isGranted) {
      print('permission granted');
    }
<<<<<<< HEAD
    String filename = data['title'] + " - " + data['artist'] + ".m4a";
=======
    String filename =
        data['title'].toString().replaceAll("\\", "").replaceAll(".", "") +
            " - " +
            data['artist'].toString().replaceAll("\\", "").replaceAll(".", "") +
            ".m4a";
    filename = filename.replaceAll("?", "").replaceAll("\*", "");
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
    if (dlPath == '')
      dlPath = await ExtStorage.getExternalStoragePublicDirectory(
          ExtStorage.DIRECTORY_MUSIC);

    bool exists = await File(dlPath + "/" + filename).exists();
    if (exists) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Already Exists",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
<<<<<<< HEAD
                Row(
                  children: [
                    Text(
                      '"${data['title']}" already exists.\nDo you want to download it again?',
                      softWrap: true,
                      // style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
=======
                Container(
                  width: 500,
                  child: Row(
                    children: [
                      Text(
                        '"${data['title']}" already exists.\nDo you want to download it again?',
                        softWrap: true,
                        // style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.grey[700],
                ),
<<<<<<< HEAD
                child: Text("Yes"),
                onPressed: () async {
                  Navigator.pop(context);
                  while (await File(dlPath + "/" + filename).exists()) {
                    filename = filename.replaceAll('.m4a', ' (1).m4a');
                  }
=======
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  lastDownloadId = data['id'];
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.grey[700],
                ),
                child: Text("Yes, but Replace Old"),
                onPressed: () async {
                  Navigator.pop(context);
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
                  downloadSong(context, dlPath, filename, data);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
<<<<<<< HEAD
                  primary: Theme.of(context).accentColor,
                  backgroundColor: Theme.of(context).accentColor,
                ),
                child: Text(
                  "No",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  lastDownloadId = data['id'];
                  Navigator.pop(context);
=======
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).accentColor,
                ),
                child: Text("Yes"),
                onPressed: () async {
                  Navigator.pop(context);
                  while (await File(dlPath + "/" + filename).exists()) {
                    filename = filename.replaceAll('.m4a', ' (1).m4a');
                  }
                  downloadSong(context, dlPath, filename, data);
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
                },
              ),
              SizedBox(
                width: 5,
              ),
            ],
          );
        },
      );
    } else {
      downloadSong(context, dlPath, filename, data);
    }
  }

  Future<void> downloadSong(
      BuildContext context, String dlPath, String filename, Map data) async {
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    progress = null;
    notifyListeners();
    String filepath;
    String filepath2;
    List<int> _bytes = [];
<<<<<<< HEAD
    final artname = data['title'] + "artwork.jpg";
    Directory appDir = await getApplicationDocumentsDirectory();
    String appPath = appDir.path;
=======
    String lyrics;
    final artname =
        data['title'].replaceAll("?", "").replaceAll("\*", "") + "artwork.jpg";
    Directory appDir = await getApplicationDocumentsDirectory();
    String appPath = appDir.path;
    if (data['url'].toString().contains('google')) {
      filename = filename.replaceAll('.m4a', '.weba');
    }
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
    try {
      await File(dlPath + "/" + filename)
          .create(recursive: true)
          .then((value) => filepath = value.path);
      print("created audio file");
      await File(appPath + "/" + artname)
          .create(recursive: true)
          .then((value) => filepath2 = value.path);
    } catch (e) {
      await [
        Permission.manageExternalStorage,
      ].request();
      await File(dlPath + "/" + filename)
          .create(recursive: true)
          .then((value) => filepath = value.path);
      print("created audio file");
      await File(appPath + "/" + artname)
          .create(recursive: true)
          .then((value) => filepath2 = value.path);
    }
    debugPrint('Audio path $filepath');
    debugPrint('Image path $filepath2');
<<<<<<< HEAD

    scaffoldMessenger.showSnackBar(
      SnackBar(
        elevation: 6,
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Downloading "${data['title'].toString()}" in $preferredDownloadQuality',
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).accentColor,
          label: 'Ok',
          onPressed: () {},
        ),
      ),
    );
=======
    try {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          elevation: 6,
          backgroundColor: Colors.grey[900],
          behavior: SnackBarBehavior.floating,
          content: Text(
            filepath.endsWith('.weba')
                ? 'Downloading "${data['title'].toString()}" in Best Quality Available'
                : 'Downloading "${data['title'].toString()}" in $preferredDownloadQuality',
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            textColor: Theme.of(context).accentColor,
            label: 'Ok',
            onPressed: () {},
          ),
        ),
      );
    } catch (e) {
      print("Failed to show Snackbar: $e");
    }
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e

    String kUrl = data['url'].replaceAll(
        "_96.", "_${preferredDownloadQuality.replaceAll(' kbps', '')}.");
    final response = await Client().send(Request('GET', Uri.parse(kUrl)));
    int total = response.contentLength ?? 0;
    int recieved = 0;
    response.stream.asBroadcastStream();
    response.stream.listen((value) {
      _bytes.addAll(value);
      try {
        recieved += value.length;
        progress = recieved / total;
        notifyListeners();
      } catch (e) {}
    }).onDone(() async {
      final file = File("${(filepath)}");
      await file.writeAsBytes(_bytes);

      HttpClientRequest request2 =
          await HttpClient().getUrl(Uri.parse(data['image']));
      HttpClientResponse response2 = await request2.close();
      final bytes2 = await consolidateHttpClientResponseBytes(response2);
      File file2 = File(filepath2);

      await file2.writeAsBytes(bytes2);
<<<<<<< HEAD
=======
      try {
        lyrics = downloadLyrics ? await getLyrics(data) : '';
      } catch (e) {
        print('Error fetching lyrics: $e');
        lyrics = '';
      }
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
      debugPrint("Started tag editing");

      final Tag tag = Tag(
        title: data['title'],
        artist: data['artist'],
<<<<<<< HEAD
        albumArtist: data['artist'].toString()?.split(', ')[0],
=======
        albumArtist:
            data['album_artist'] ?? data['artist'].toString()?.split(', ')[0],
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
        artwork: filepath2.toString(),
        album: data['album'],
        genre: data['language'],
        year: data['year'],
<<<<<<< HEAD
=======
        lyrics: lyrics,
>>>>>>> b95d00f731f44a79616972f843ac38397ab2d14e
        comment: 'BlackHole',
      );

      final tagger = Audiotagger();
      await tagger.writeTags(
        path: filepath,
        tag: tag,
      );
      await Future.delayed(const Duration(seconds: 1), () {});
      if (await file2.exists()) {
        await file2.delete();
      }
      debugPrint("Done");
      lastDownloadId = data['id'];
      progress = 0.0;
      notifyListeners();

      scaffoldMessenger.showSnackBar(SnackBar(
        elevation: 6,
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
        content: Text(
          '"${data['title'].toString()}" has been downloaded',
          style: TextStyle(color: Colors.white),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).accentColor,
          label: 'Ok',
          onPressed: () {},
        ),
      ));
    });
  }
}

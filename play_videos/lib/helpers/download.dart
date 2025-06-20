import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> download(
  String fileId,
  String fileNme, {
  Function(double progress)? onProgress,
}) async {

  var status = await Permission.storage.request();
  if (!status.isGranted) {
    print("permission denied");
    onProgress?.call(-1);
    return;
  }

  final Directory directory;

  if (Platform.isAndroid) {
    final dirs = await getExternalStorageDirectories();
    if (dirs == null || dirs.isEmpty) {
      print("No external storage directory available");
      onProgress?.call(-1);
      return;
    }
    directory = dirs[0];
  } else {
    directory = await getApplicationDocumentsDirectory();
  }

  final savePath = "${directory.path}/$fileNme.mp4";

  final url = 'https://drive.google.com/uc?export=download&id=$fileId';

  try {
    await Dio().download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          final progress = received / total;
          print("Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
          onProgress?.call(progress);
        }
      },
    );
    print("Download Completed: $savePath");
    onProgress?.call(1.0);
  } catch (e) {
    print("Download failed: $e");
    onProgress?.call(-1);
  }
}

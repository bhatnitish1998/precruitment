import 'package:flutter/material.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:permission_handler/permission_handler.dart';

class FileView extends StatelessWidget {
  final String name;
  final String url;
  FileView(this.name, this.url);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.picture_as_pdf,
        color: Theme.of(context).accentColor,
      ),
      title: Text(name),
      trailing: IconButton(
        icon: Icon(
          Icons.file_download,
          color: Theme.of(context).accentColor,
        ),
        onPressed: () async {
          final status = await Permission.storage.request().isGranted;
          print(status);
          final downloadsDirectory =
              // await syspaths.getExternalStorageDirectory();
              await DownloadsPathProvider.downloadsDirectory;
          await FlutterDownloader.enqueue(
            url: url,
            fileName: name,
            savedDir: downloadsDirectory.path,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );

          print(downloadsDirectory);
        },
      ),
    );
  }
}

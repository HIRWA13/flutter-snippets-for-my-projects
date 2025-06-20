import 'package:flutter/material.dart';
import 'package:play_videos/helpers/download.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoId;

  const CustomVideoPlayer({super.key, required this.videoId});

  @override
  CustomVideoPlayerState createState() => CustomVideoPlayerState();
}

class CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  double _downloadProgress = 0;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();

    final videoUrl =
        'https://drive.google.com/uc?export=download&id=${widget.videoId}';
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});

        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startDownload() {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0;
    });

    // https://drive.google.com/file/d/1SkfS5tnSoMjp48QOfaX3J4EgVaYN01R2/view?usp=sharing
    download(
      widget.videoId,
      "Idea 25 - Gibran Alcocer",
      onProgress: (progress) {
        setState(() {
          if (progress < 0) {
            _isDownloading = false;
            _downloadProgress = 0;

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Download Failed")));
          } else if (progress >= 1) {
            _isDownloading = false;
            _downloadProgress = 1;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Download completed")));
          } else {
            _downloadProgress = progress;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: Center(
        child: Column(
          children: [
            _controller.value.isInitialized
                ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                : AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Loading video...',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            SizedBox(height: 20),

            if (_isDownloading)
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "${(_downloadProgress * 100).toStringAsFixed(0)}%",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

            Container(
              width: 200,
              height: 50,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  if (_downloadProgress > 0)
                    Positioned.fill(
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _downloadProgress,
                        child: Container(color: Colors.green.shade300),
                      ),
                    ),

                  Positioned.fill(
                    child: ElevatedButton.icon(
                      onPressed:
                          _isDownloading || _downloadProgress == 1
                              ? null
                              : _startDownload,
                      icon: Icon(
                        _downloadProgress == 1
                            ? Icons.check
                            : Icons.download_rounded,
                        color: Colors.white,
                      ),
                      label: Text(
                        _downloadProgress == 1
                            ? 'Downloaded'
                            : _isDownloading
                            ? 'Downloading...'
                            : 'Download',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _downloadProgress == 1
                                ? Colors.green.shade300
                                : Colors.blue.shade300,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade700,
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}

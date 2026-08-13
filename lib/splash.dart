import 'package:api/footer.dart';
import 'package:api/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset(
      "assets/videos/hello.mp4",
    );

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();

    if (!mounted) return;

    setState(() {});

    _controller.play();

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration &&
          !_hasNavigated) {
        _hasNavigated = true;
        checkToken();
      }
    });
  }

  Future<void> checkToken() async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString("accessToken");
       print("TOKEN VALUE= $accessToken");


      if (!mounted) return;
      if (accessToken == null) {
    print("NO TOKEN= login page");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  } else {
    print("TOKEN FOUND= footer page");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FooterPage(),
      ),
    );
  }
}

      
      
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                const Text(
                  "Welcome to Universal Mart",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

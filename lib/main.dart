import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const HalloweenApp());

class HalloweenApp extends StatelessWidget {
  const HalloweenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "A Happily Haunted Halloween",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 20)),
      ),
      home: const StoryBook(),
    );
  }
}

class StoryBook extends StatefulWidget {
  const StoryBook({super.key});

  @override
  State<StoryBook> createState() => _StoryBookState();
}

class _StoryBookState extends State<StoryBook> {
  final PageController _controller = PageController();
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  Future<void> playSound(String asset) async {
    await _player.play(AssetSource(asset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: _controller, children: [
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(const HalloweenApp());

class HalloweenApp extends StatelessWidget {
  const HalloweenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Halloween Storybook",
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

  @override
  void initState() {
    super.initState();
    playSound('sounds/intro.mp3');
  }

  Future<void> playSound(String asset) async {
    await _player.play(AssetSource(asset));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [TitlePage(playSound: playSound, controller: _controller)],
      ),
    );
  }
}

// TITLE PAGE
class TitlePage extends StatelessWidget {
  final Future<void> Function(String) playSound;
  final PageController controller;

  const TitlePage({
    super.key,
    required this.playSound,
    required this.controller,
  });

  @override
  Widget build(Object context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "A Happily Haunted Halloween",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.orange, fontSize: 40),
        ),
        SizedBox(height: 50),
        IconButton(
          icon: Icon(Icons.menu_book),
          iconSize: 200,
          color: Colors.purple,
          onPressed: () => controller.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
          ),
        ),
        SizedBox(height: 50),
        TextButton(
          onPressed: () => controller.nextPage(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeIn,
          ),
          child: Text(
            'ENTER... IF YOU DARE',
            style: TextStyle(fontSize: 25, color: Colors.green),
          ),
        ),
      ],
    );
  }
}

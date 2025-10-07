import 'dart:math';

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
        children: [
          TitlePage(playSound: playSound, controller: _controller),
          Page1(playSound: playSound),
          Page2(playSound: playSound),
          Page3(playSound: playSound),
          Page4(playSound: playSound),
        ],
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

class Page1 extends StatefulWidget {
  final Future<void> Function(String) playSound;
  const Page1({super.key, required this.playSound});

  @override
  State<Page1> createState() => _Page1State();
}

// PAGE 1 - Glowing Moon
class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glow;

  @override
  void initState() {
    super.initState();
    widget.playSound('sounds/wolf_howl.mp3');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glow = Tween(begin: 0.5, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _glow,
                builder: (context, child) => Opacity(
                  opacity: _glow.value,
                  child: const Icon(
                    Icons.circle,
                    size: 200,
                    color: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "It was a crisp Halloween night,\n"
                "and I was ready to trick or treat\n"
                "under the glowing moonlight.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// PAGE 2 - Pumpkin Patch
class Page2 extends StatefulWidget {
  final Future<void> Function(String) playSound;
  const Page2({super.key, required this.playSound});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    widget.playSound('sounds/wind.mp3');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _bounce = Tween(begin: 0.0, end: 15.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.asset('assets/images/pumpkin_patch.jpg')),
        Center(
          child: AnimatedBuilder(
            animation: _bounce,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, -_bounce.value),
              child: Image.asset('assets/images/pumpkin.png', width: 100),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "As I passed the pumpkin patch\n the pumpkins bounced "
              "and laughed\n as the wind swirled the falling leaves.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orangeAccent),
            ),
          ),
        ),
      ],
    );
  }
}

// PAGE 3 - Ghostly Cemetery
class Page3 extends StatefulWidget {
  final Future<void> Function(String) playSound;
  const Page3({super.key, required this.playSound});
  
  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    widget.playSound('sounds/ghost.mp3');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _fade = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.asset('assets/images/cemetery.jpg')),
        Center(
          child: AnimatedBuilder(
            animation: _fade,
            builder: (context, child) => Opacity(
              opacity: _fade.value,
              child: Image.asset('assets/images/ghost.webp', height: 75,)
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Through the cemetery I crept.\n"
              "Friendly ghosts drifted in and out of sight,\n"
              "whispering softly.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

// PAGE 4 - The House
class Page4 extends StatefulWidget {
  final Future<void> Function(String) playSound;
  const Page4({super.key, required this.playSound});
  
  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  bool _doorOpen = false;

  void _openDoor() {
    setState(() => _doorOpen = true);
    widget.playSound('sounds/bats.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onTap: _openDoor,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/images/house.jpg')
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Finally, I reached a house.\n"
              "The door creaked open — out flew bats!\n"
              "I filled my bag with treats.\n"
              " Mission acomplished!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.purpleAccent),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LikeButtonPage(),
    );
  }
}

class LikeButtonPage extends StatefulWidget {
  const LikeButtonPage({super.key});

  @override
  _LikeButtonPageState createState() => _LikeButtonPageState();
}

class _LikeButtonPageState extends State<LikeButtonPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onLikeButtonPressed() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lottie Like Button'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _onLikeButtonPressed,
          child: Lottie.network(
            'https://lottie.host/17a076e4-fcb1-455d-8eca-574d7f84fdfa/zZzt9FBsjM.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
            },
          ),
        ),
      ),
    );
  }
}

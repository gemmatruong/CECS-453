import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AffirmationsPage(),
    );
  }
}

class AffirmationsPage extends StatelessWidget {
  const AffirmationsPage({super.key});

  final List<String> images = const [
    'assets/images/cat.jpg',
    'assets/images/fireflies.jpg',
    'assets/images/howl.jpg',
    'assets/images/kiki.jpg',
    'assets/images/onepiece.jpg',
    'assets/images/spiritedaway.jpg',
    'assets/images/totoro.jpg',
    'assets/images/up.jpg'
  ];

  final List<String> affirmations = const [
    'I bring kindness and warmth wherever I go.',
    'I am strong, and I can protect the people I love.',
    'I am capable of creating my own path.',
    'I believe in myself as I grow and learn.',
    'I am brave enough to follow my dreams.',
    'I can find light even during difficult times.',
    'I enjoy the simple and peaceful moments in life.',
    'It is never too late to begin a new adventure.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gemma's Daily Positive Vibes",
          style: TextStyle(
            color: Color(0xffECE3CE),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff4B5945),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: affirmations.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: Colors.lightGreen[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  images[index],
                  height: 450,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    affirmations[index],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}


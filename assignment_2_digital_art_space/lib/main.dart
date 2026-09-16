import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ArtSpace(),
    );
  }
}

class ArtSpace extends StatefulWidget {
  const ArtSpace({super.key});

  @override State<ArtSpace> createState() {
    return _ArtSpaceState();
  }
}

class _ArtSpaceState extends State<ArtSpace> {
  int pictureIndex = 0;

  final List<String> pictures = [
    'assets/images/giraffe.png',
    'assets/images/donkey.png',
    'assets/images/horse.png',
    'assets/images/cat.png',
    'assets/images/bird.png',
    'assets/images/owl.png',
    'assets/images/dog.png',
    'assets/images/elephant.png',
    'assets/images/zebra.png'
  ];

  final List<String> titles = [
    'GIRAFFE & CHANDELIER',
    'Donkey in the mountain',
    'Somebody Told Me',
    'Goliath',
    'Tender Care in the Nest',
    'The more it sees, the less it talks',
    'Doberman',
    'Big First Impression',
    'The Tree House'
  ];

  final List<String> artists = [
    'Miss Aniela',
    'Luciano Baccaro',
    'Alessandro Passerini',
    'Alessandro Passerini',
    'M M Jakaria',
    'Tina Sturzenegger',
    'Noa Nick',
    'Cheraine Collette',
    'Nikolina Petolas'
  ];

  final List<String> years = [
    '2016',
    '2020',
    '2014',
    '2009',
    '2012',
    '2025',
    '2023',
    '2020',
    '2019'
  ];

  void previousPicture() {
    setState(() {
      if (pictureIndex == 0) {
        pictureIndex = pictures.length - 1;
      }
      else {
        pictureIndex = pictureIndex - 1;
      }
    });
  }

    void nextPicture() {
      setState(() {
        if (pictureIndex == pictures.length - 1) {
          pictureIndex = 0;
        }
        else {
          pictureIndex = pictureIndex + 1;
        }
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Gemma's Art Space",
            style: TextStyle(
              color: Color(0xffECE3CE),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff4B5945),
        ),

        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),

                Container(
                  height: 500,
                  width: 400,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    pictures[pictureIndex],
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 25),

                Container(
                  width: 350,
                  padding: const EdgeInsets.all(10),
                  color: const Color(0xffD1D8BE),
                  child: Column(
                    children: [
                      Text(
                        titles[pictureIndex],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height :8),

                      Text(
                        '${artists[pictureIndex]} (${years[pictureIndex]})',
                        style: const TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: previousPicture,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffb9d5bc),
                        foregroundColor: Colors.black,
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),

                    const SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: nextPicture,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffb9d5bc),
                        foregroundColor: Colors.black,
                      ),
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      );
    }
  }
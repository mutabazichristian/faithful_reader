import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class AppColors {
  static const Color navy = Color(0xFF264654);
  static const Color mint = Color(0xFFE0FCFB);
  static const Color teal = Color(0xFF299D8F);
  static const Color coral = Color(0xFFF3A361);
  static const Color rust = Color(0xFFE76F51);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bible Verse App',
      theme: ThemeData(
        primaryColor: AppColors.navy,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.navy,
          secondary: AppColors.teal,
        ),
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
          bodyMedium: TextStyle(
            fontSize: 16.0,
            color: AppColors.navy,
          ),
        ),
      ),
      home: MoodSelectionScreen(),
    );
  }
}

class MoodSelectionScreen extends StatefulWidget {
  @override
  _MoodSelectionScreenState createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends State<MoodSelectionScreen> {
  String selectedMood = 'Grateful';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildMoodButton('Grateful'),
                  _buildMoodButton('Happy'),
                  _buildMoodButton('Excited'),
                  _buildMoodButton('Peaceful'),
                  _buildMoodButton('Curious'),
                  _buildMoodButton('Thoughtful'),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerseDisplayScreen(selectedMood),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.coral,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(50),
                ),
                child: const Text('Get Verse'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoodButton(String mood) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedMood = mood;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedMood == mood ? AppColors.coral : AppColors.navy,
        foregroundColor: selectedMood == mood ? AppColors.mint : AppColors.mint,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      child: Text(mood),
    );
  }
}

class VerseDisplayScreen extends StatefulWidget {
  final String selectedMood;
  VerseDisplayScreen(this.selectedMood);

  @override
  _VerseDisplayScreenState createState() => _VerseDisplayScreenState();
}

class _VerseDisplayScreenState extends State<VerseDisplayScreen> {
  late Future<BibleVerse> _bibleVerse;

  @override
  void initState() {
    super.initState();
    _bibleVerse = _fetchBibleVerse();
  }

  Future<BibleVerse> _fetchBibleVerse() async {
    final verseMap = {
      'Grateful': 'psalm 107:1',
      'Happy': 'proverbs 15:13',
      'Excited': 'philippians 4:4',
      'Peaceful': 'john 14:27',
      'Curious': 'proverbs 2:6',
      'Thoughtful': 'james 1:5',
    };

    final verseReference = verseMap[widget.selectedMood] ?? 'john 3:16';
    final response =
        await http.get(Uri.parse('https://bible-api.com/$verseReference'));

    if (response.statusCode == 200) {
      return BibleVerse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch Bible verse');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<BibleVerse>(
          future: _bibleVerse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Your ${widget.selectedMood} Verse',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Text(
                      snapshot.data!.text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.navy,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                VerseDetailsScreen(snapshot.data!),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.coral,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(50),
                      ),
                      child: const Text('More Details'),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class VerseDetailsScreen extends StatelessWidget {
  final BibleVerse bibleVerse;

  VerseDetailsScreen(this.bibleVerse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Bible Verse',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  bibleVerse.text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.navy,
                      ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Reference: ${bibleVerse.reference}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.navy,
                      ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Translation: ${bibleVerse.translationName}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.navy,
                      ),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Translation Note: ${bibleVerse.translationNote}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.navy,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BibleVerse {
  final String reference;
  final String text;
  final String translationName;
  final String translationNote;

  BibleVerse({
    required this.reference,
    required this.text,
    required this.translationName,
    required this.translationNote,
  });

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      reference: json['reference'],
      text: json['text'],
      translationName: json['translation_name'],
      translationNote: json['translation_note'],
    );
  }
}

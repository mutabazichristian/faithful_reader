import 'package:flutter/material.dart';
import '../widgets/circle_button.dart';
import '../widgets/mood_button.dart';
import '../routes/circular_reveal_route.dart';
import 'versescreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'How are you feeling today?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  children: _buildMoodButtons(context),
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement slider screen navigation
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerseScreen()));
                },
                child: const Text(
                  'Use slider instead',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(height: 8),
              CircleButton(
                onTap: () => _navigateToVerse(context),
                child: const Text(
                  'Read',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMoodButtons(BuildContext context) {
    final moods = [
      'Grateful',
      'Happy',
      'Excited',
      'Peaceful',
      'Confident',
      'Loved',
      'Curious',
      'Thoughtful',
      'Content',
      'Sad',
      'Tired',
      'Anxious',
      'Discouraged',
      'Stressed',
      'Reflective',
      'Seeking Guidance',
      'Weak',
      'Blessed',
      'Discontent',
      'Waiting',
      'Inspired',
      'Uncertain',
      'Overwhelmed',
      'Guilty',
      'Broken Hearted',
      'Doubtful',
      'Open-minded',
      'Ashamed',
      'Stuck',
      'Burned out',
      'Restless',
      'Misunderstood',
      'Disconnected',
    ];

    return moods
        .map((mood) => MoodButton(
              text: mood,
              onTap: () => _navigateToVerse(context),
            ))
        .toList();
  }

  void _navigateToVerse(BuildContext context) {
    Navigator.of(context).push(
      CircularRevealRoute(
        builder: (_) => const VerseScreen(),
      ),
    );
  }
}

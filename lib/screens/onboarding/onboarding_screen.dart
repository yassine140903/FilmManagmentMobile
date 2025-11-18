import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_card.dart';
import 'onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;
  bool _isUserDragging = false;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      icon: Icons.playlist_play,
      title: 'Your Movie Universe, Organized.',
      description: 'Search for any movie and curate your personal playlists.',
    ),
    OnboardingItem(
      icon: Icons.connect_without_contact,
      title: 'Connect With Your Movie Twin.',
      description: 'Discover users who share your unique movie tastes.',
    ),
    OnboardingItem(
      icon: Icons.groups,
      title: 'Share, Rate, and Discuss.',
      description: 'Rate movies and see what others in the community are watching.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) setState(() => _currentPage = next);
    });

    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_isUserDragging) return;

      int nextPage = _currentPage + 1;
      if (nextPage >= _onboardingItems.length) nextPage = 0;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoSlide() => _autoSlideTimer?.cancel();

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Logo
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.movie, color: Color(0xFF7F0DF2), size: 32),
                  SizedBox(width: 8),
                  Text(
                    'CineMatch',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Carousel
            Expanded(
              child: GestureDetector(
                onTapDown: (_) {
                  _isUserDragging = true;
                  _stopAutoSlide();
                },
                onTapUp: (_) {
                  _isUserDragging = false;
                  _startAutoSlide();
                },
                onHorizontalDragStart: (_) {
                  _isUserDragging = true;
                  _stopAutoSlide();
                },
                onHorizontalDragEnd: (_) {
                  _isUserDragging = false;
                  _startAutoSlide();
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingItems.length,
                  itemBuilder: (context, index) {
                    return OnboardingCard(item: _onboardingItems[index]);
                  },
                ),
              ),
            ),

            // Page Indicators
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingItems.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? const Color(0xFF7F0DF2)
                          : const Color(0xFF473B54),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to login or home later
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7F0DF2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Login Link
            Padding(
              padding: const EdgeInsets.only(bottom: 24, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Color(0xFFAB9CBA),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login page later
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Color(0xFF7F0DF2),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

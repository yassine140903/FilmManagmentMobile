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
            const SizedBox(height: 32),
            Expanded(
              child: GestureDetector(
                onTapDown: (_) { _isUserDragging = true; _stopAutoSlide(); },
                onTapUp: (_) { _isUserDragging = false; _startAutoSlide(); },
                onHorizontalDragStart: (_) { _isUserDragging = true; _stopAutoSlide(); },
                onHorizontalDragEnd: (_) { _isUserDragging = false; _startAutoSlide(); },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardingItems.length,
                  itemBuilder: (context, index) {
                    return OnboardingCard(item: _onboardingItems[index]);
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingItems.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? const Color(0xFF7F0DF2) : const Color(0xFF473B54),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
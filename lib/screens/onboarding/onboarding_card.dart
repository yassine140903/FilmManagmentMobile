import 'package:flutter/material.dart';
import 'onboarding_item.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              color: const Color(0xFF251933),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              item.icon,
              size: 120,
              color: const Color(0xFF7F0DF2).withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFAB9CBA),
            ),
          ),
        ],
      ),
    );
  }
}
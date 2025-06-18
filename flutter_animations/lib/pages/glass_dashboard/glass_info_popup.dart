import 'dart:ui';
import 'package:flutter/material.dart';

class GlassInfoPopup extends StatelessWidget {
  final int selectedIndex;

  const GlassInfoPopup({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contents = [
      {
        'title': 'Home',
        'description': 'Welcome to your dashboard',
        'icon': Icons.home,
        'color': Colors.blue,
        'items': [
          {'title': 'Recent Activity', 'icon': Icons.access_time},
          {'title': 'Favorites', 'icon': Icons.favorite},
          {'title': 'Trending', 'icon': Icons.trending_up},
        ],
      },
      {
        'title': 'Search',
        'description': 'Find what you need',
        'icon': Icons.search,
        'color': Colors.purple,
        'items': [
          {'title': 'Categories', 'icon': Icons.category},
          {'title': 'Popular', 'icon': Icons.whatshot},
          {'title': 'Recent Searches', 'icon': Icons.history},
        ],
      },
      {
        'title': 'Notifications',
        'description': 'Stay updated with recent alerts',
        'icon': Icons.notifications,
        'color': Colors.orange,
        'items': [
          {'title': 'Unread', 'icon': Icons.mark_email_unread},
          {'title': 'Mentions', 'icon': Icons.alternate_email},
          {'title': 'Direct Messages', 'icon': Icons.message},
        ],
      },
      {
        'title': 'Profile',
        'description': 'Your personal information',
        'icon': Icons.person,
        'color': Colors.green,
        'items': [
          {'title': 'Settings', 'icon': Icons.settings},
          {'title': 'Privacy', 'icon': Icons.security},
          {'title': 'Help & Support', 'icon': Icons.help},
        ],
      },
    ];

    final currentContent = contents[selectedIndex];

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: currentContent['color'].withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      currentContent['icon'],
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentContent['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentContent['description'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white30),
              const SizedBox(height: 10),
              ...List.generate((currentContent['items'] as List).length, (
                index,
              ) {
                final item = currentContent['items'][index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(item['icon'], color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white54,
                        size: 16,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

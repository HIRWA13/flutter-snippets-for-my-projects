import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'glass_card.dart';
import 'glass_info_popup.dart';

class GlassDashboard extends StatefulWidget {
  const GlassDashboard({super.key});

  @override
  State<GlassDashboard> createState() => _GlassDashboardState();
}

class _GlassDashboardState extends State<GlassDashboard>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _showPopup = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      if (_selectedIndex == index && _showPopup) {
        // If tapping the same item again, just hide the popup
        _showPopup = false;
        _animationController.reverse();
      } else {
        _selectedIndex = index;
        _showPopup = true;
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Sample navigation items
    final items = const [
      Icon(CupertinoIcons.home, size: 28, color: Colors.white),
      Icon(CupertinoIcons.search, size: 28, color: Colors.white),
      Icon(CupertinoIcons.bell, size: 28, color: Colors.white),
      Icon(CupertinoIcons.person, size: 28, color: Colors.white),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'iOS‑Style Glass UI',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              return GlassCard(
                child: items[index],
                onTap: () => _onNavItemTapped(index),
              );
            }),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background & overlay
          Positioned.fill(
            child: Image.asset('assets/images/lion.jpg', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.25)),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (ctx, constraints) {
                  // Compute crossAxisCount based on width
                  int crossAxis = constraints.maxWidth ~/ 180;
                  crossAxis = crossAxis.clamp(1, 4);
                  return GridView.builder(
                    itemCount: 6,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxis,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (_, i) {
                      // Example icons
                      final icons = [
                        Icons.car_repair,
                        Icons.local_car_wash,
                        Icons.car_rental_outlined,
                        Icons.card_membership_rounded,
                        Icons.pedal_bike_outlined,
                        Icons.map,
                      ];
                      return GlassCard(
                        child: Icon(icons[i], size: 40, color: Colors.white),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          // Glass Popup
          if (_showPopup)
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: GlassInfoPopup(selectedIndex: _selectedIndex),
              ),
            ),
        ],
      ),
    );
  }
}

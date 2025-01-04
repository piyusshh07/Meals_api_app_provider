import 'package:flutter/material.dart';

/// A customizable bottom navigation bar with a gradient indicator and transitions for each screen.
class GradientBottomNavbar extends StatefulWidget {
  final List<GradientNavItem> items;
  final List<Widget> screens;
  final double indicatorHeight;
  final double indicatorWidth;
  final BorderRadiusGeometry indicatorBorderRadius;
  final Gradient indicatorGradient;
  final Duration animationDuration;
  final Curve animationCurve;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final Color backgroundColor;
  final Color counterColor;
  final BorderRadiusGeometry? barBorderRadius;

  const GradientBottomNavbar({
    super.key,
    required this.items,
    required this.screens,
    this.indicatorHeight = 50.0,
    this.indicatorWidth = 60.0,
    this.barBorderRadius,
    this.indicatorBorderRadius = const BorderRadius.all(Radius.circular(20)),
    this.indicatorGradient = const LinearGradient(
      colors: [
        Color(0xFF00AAE5), // Light Blue
        Color(0xFF00008B), // Dark Blue
      ],
    ),
    this.backgroundColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.selectedItemColor = Colors.white,
    this.unselectedItemColor = Colors.black,
    this.counterColor = const Color.fromARGB(255, 181, 0, 0),

  }) : assert(items.length == screens.length,
  "Items and screens must have the same length");

  @override
  State<GradientBottomNavbar> createState() => _GradientBottomNavbarState();
}

class _GradientBottomNavbarState extends State<GradientBottomNavbar> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  double _calculateIndicatorPosition(BuildContext context, int index) {
    final totalWidth = MediaQuery.of(context).size.width;
    final sectionWidth = totalWidth / widget.items.length;
    return (sectionWidth * index) + (sectionWidth - widget.indicatorWidth) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: widget.animationDuration,
        switchInCurve: widget.animationCurve,
        switchOutCurve: widget.animationCurve,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: widget.screens[_selectedIndex],
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Navigation Bar
          ClipRRect(
            borderRadius: widget.barBorderRadius ?? BorderRadius.zero,
            child: NavigationBar(
              backgroundColor: widget.backgroundColor,
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onDestinationSelected,
              indicatorColor: Colors.transparent,
              destinations: widget.items.asMap().entries.map(
                    (entry) {
                  final int index = entry.key;
                  final GradientNavItem item = entry.value;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      NavigationDestination(
                        icon: Icon(
                          item.icon,
                          color: widget.unselectedItemColor,
                        ),
                        label: item.label,
                      ),
                      // Red Counter on Top of Icon (if not selected)
                      if (item.counter != null && _selectedIndex != index)
                        Positioned(
                          top: MediaQuery.of(context).size.height *
                              0.005, // 0.5% of screen height
                          right: MediaQuery.of(context).size.width *
                              0.06, // 6% of screen width
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: widget.counterColor,
                              shape: BoxShape.circle,
                            ),
                            constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width *
                                  0.04, // 4% of screen width
                              minHeight: MediaQuery.of(context).size.width *
                                  0.04, // 4% of screen width
                            ),
                            child: Center(
                              child: Text(
                                item.counter.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),

          // Gradient Indicator
          AnimatedPositioned(
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            top: 2, // Adjust based on the NavigationBar height
            left: _calculateIndicatorPosition(context, _selectedIndex),
            child: Stack(
              children: [
                Container(
                  width: widget.indicatorWidth,
                  height: widget.indicatorHeight,
                  decoration: BoxDecoration(
                    gradient: widget.indicatorGradient,
                    borderRadius: widget.indicatorBorderRadius,
                  ),
                  child: Center(
                    child: Icon(
                      widget.items[_selectedIndex].icon,
                      color: widget.selectedItemColor,
                    ),
                  ),
                ),
                if (widget.items[_selectedIndex].counter != null)
                  Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: widget.counterColor,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width * 0.04,
                        minHeight: MediaQuery.of(context).size.width * 0.04,
                      ),
                      child: Center(
                        child: Text(
                          widget.items[_selectedIndex].counter.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Model class for Navigation Item.
class GradientNavItem {
  final IconData icon;
  final String label;
  final int? counter; // Optional counter for displaying a badge

  GradientNavItem({
    required this.icon,
    required this.label,
    this.counter,
  });
}

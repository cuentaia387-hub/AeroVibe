import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'aero_icons.dart';

class AeroBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AeroBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 8),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4), // Bright Glass
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, const AeroHomeIcon(), 'Inicio'),
                _buildNavItem(1, const AeroNotesIcon(), 'Notas'),
                _buildNavItem(2, const AeroCenterIcon(), 'Centro'),
                _buildNavItem(3, const AeroSettingsIcon(), 'Ajustes'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, Widget aeroIcon, String label) {
    final isSelected = currentIndex == index;
    final color = isSelected ? AeroColors.waterBlue : AeroColors.mutedText;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.8) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isSelected ? [
              BoxShadow(
                color: AeroColors.waterBlue.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ] : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.2 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: aeroIcon,
              ),
              if (isSelected) ...[
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

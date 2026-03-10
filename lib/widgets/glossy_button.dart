import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlossyButton extends StatefulWidget {
  final String label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final double borderRadius;
  final double height;
  final double? width;
  final TextStyle? textStyle;
  final bool isSmall;

  const GlossyButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.gradient = AeroColors.aquaGradient,
    this.borderRadius = 50,
    this.height = 52,
    this.width,
    this.textStyle,
    this.isSmall = false,
  });

  @override
  State<GlossyButton> createState() => _GlossyButtonState();
}

class _GlossyButtonState extends State<GlossyButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: widget.isSmall ? 36 : widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: widget.gradient,
            boxShadow: [
              BoxShadow(
                color: AeroColors.primaryAqua.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Top gloss highlight
              Positioned(
                top: 0,
                left: 2,
                right: 2,
                height: (widget.isSmall ? 36 : widget.height) * 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(widget.borderRadius),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x55FFFFFF),
                        Color(0x00FFFFFF),
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      widget.icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: widget.textStyle ??
                          TextStyle(
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: widget.isSmall ? 13 : 15,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlossyIconButton extends StatefulWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final double size;
  final Gradient? gradient;
  final Color? color;

  const GlossyIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.gradient,
    this.color,
  });

  @override
  State<GlossyIconButton> createState() => _GlossyIconButtonState();
}

class _GlossyIconButtonState extends State<GlossyIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: widget.gradient ?? AeroColors.aquaGradient,
            color: widget.color,
            boxShadow: [
              BoxShadow(
                color: AeroColors.primaryAqua.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Gloss
              Positioned(
                top: 2,
                left: 2,
                right: 2,
                height: widget.size * 0.45,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x55FFFFFF), Color(0x00FFFFFF)],
                    ),
                  ),
                ),
              ),
              Center(child: widget.icon),
            ],
          ),
        ),
      ),
    );
  }
}

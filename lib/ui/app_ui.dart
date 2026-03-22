import 'package:flutter/material.dart';

/// Uygulama genelinde modern görünüm sabitleri ve yardımcı widget'lar.
abstract final class TarimUi {
  static const double radiusXl = 28;
  static const double radiusLg = 22;
  static const double radiusMd = 16;
  static const double radiusSm = 12;

  static const Color forest = Color(0xFF1B4332);
  static const Color mint = Color(0xFF2D6A4F);
  static const Color leaf = Color(0xFF40916C);
  static const Color sage = Color(0xFF95D5B2);
  static const Color cream = Color(0xFFF8FAF6);
  static const Color earth = Color(0xFF8B6914);
  static const Color clay = Color(0xFF6D4C41);
  static const Color sky = Color(0xFF1D6FEB);

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.07),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> glowShadow(Color c) => [
        BoxShadow(
          color: c.withValues(alpha: 0.35),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ];

  static BoxDecoration pageBackground() => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF4F9F4),
            Color(0xFFE8F2EC),
            Color(0xFFD8EBE0),
          ],
        ),
      );

  /// Ana sayfa üst gradient (yeşil tonları).
  static const LinearGradient heroGreen = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF2D6A4F),
      Color(0xFF1B4332),
      Color(0xFF081C15),
    ],
  );
}

/// Gölgeli, hafif “cam” hissi veren kart.
class TarimSurfaceCard extends StatelessWidget {
  const TarimSurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(TarimUi.radiusLg),
        border: Border.all(
          color: borderColor ?? Colors.white.withValues(alpha: 0.8),
          width: 1,
        ),
        boxShadow: TarimUi.softShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(TarimUi.radiusLg),
        child: Padding(padding: padding, child: child),
      ),
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TarimUi.radiusLg),
        child: card,
      ),
    );
  }
}

class TarimGradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TarimGradientAppBar({
    super.key,
    required this.title,
    this.colors = const [
      TarimUi.forest,
      TarimUi.mint,
    ],
  });

  final String title;
  final List<Color> colors;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.last.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
      foregroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

class TarimSectionTitle extends StatelessWidget {
  const TarimSectionTitle({
    super.key,
    required this.title,
    this.icon,
    this.trailing,
  });

  final String title;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    TarimUi.leaf.withValues(alpha: 0.2),
                    TarimUi.sage.withValues(alpha: 0.35),
                  ],
                ),
                borderRadius: BorderRadius.circular(TarimUi.radiusSm),
              ),
              child: Icon(icon, color: TarimUi.forest, size: 20),
            ),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: TarimUi.forest,
                    letterSpacing: -0.2,
                  ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class TarimEmptyState extends StatelessWidget {
  const TarimEmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.action,
  });

  final IconData icon;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: TarimSurfaceCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 52, color: TarimUi.leaf.withValues(alpha: 0.7)),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
              if (action != null) ...[
                const SizedBox(height: 20),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

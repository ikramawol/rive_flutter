import 'package:flutter/material.dart';
import 'package:rive_flutter_app/core/theme/theme_toggle_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showLogo;
  final bool showThemeToggle;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.showLogo = true,
    this.showThemeToggle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      centerTitle: true,
      title: showLogo
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo1.png',
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 8),
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
              ],
            )
          : title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                )
              : null,
      actions: [
        if (showThemeToggle) const ThemeToggleWidget(),
        if (actions != null) ...actions!,
      ],
      leading: null, // Remove back button
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
} 
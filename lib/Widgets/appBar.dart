import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;

  CustomAppBar({
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: actions,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBackButtonPressed ?? () => Navigator.of(context).pop(),
      )
          : null,
    );
  }
//nihioh9
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
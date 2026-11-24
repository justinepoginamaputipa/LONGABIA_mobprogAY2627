import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'custom_text.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    this.imagePath,
    this.radius = 20,
  });

  final String name;
  final String? imagePath;
  final double radius;

  String get _initials {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final double r = ScreenUtil().setSp(radius);
    return CircleAvatar(
      radius: r,
      backgroundColor: FB_LIGHT_PRIMARY,
      backgroundImage: imagePath != null ? AssetImage(imagePath!) : null,
      child: imagePath == null
          ? CustomFont(
              text: _initials,
              fontSize: r * 0.8,
              color: FB_DARK_PRIMARY,
              fontWeight: FontWeight.bold,
            )
          : null,
    );
  }
}

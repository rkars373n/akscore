import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamLogo extends StatelessWidget {
  final String? logoUrl;
  final double size;

  const TeamLogo({super.key, this.logoUrl, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: logoUrl != null
          ? SvgPicture.network(
              logoUrl!,
              placeholderBuilder: (context) => const CircularProgressIndicator(),
              width: size,
              height: size,
            )
          : const Icon(Icons.shield, size: 40, color: Colors.grey), // Fallback icon
    );
  }
}

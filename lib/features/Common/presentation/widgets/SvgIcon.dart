import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/Icons.dart';

class SvgIcon extends StatelessWidget 
{
  final String asset;
  final Color? color;
  final double size;
  final BoxFit fit;
  const SvgIcon({
    super.key,
    required this.asset,
    this.color,
    this.size = 24,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconAsset(asset),
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      width: size,
      height: size,
      fit: fit,
    );
  }
}

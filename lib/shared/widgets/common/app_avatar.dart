import 'dart:typed_data';

import 'package:career_portal/core/extensions/app_extensions.dart';
import 'package:career_portal/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.image,
    this.fallbackInitial,
    this.size = 40,
    this.backgroundColor,
    this.showStatusDot = false,
    this.statusDotColor,
    this.border,
    this.mimeType,
  });

  final Object? image;
  final String? fallbackInitial;
  final double size;
  final Color? backgroundColor;
  final bool showStatusDot;
  final Color? statusDotColor;
  final BoxBorder? border;
  final String? mimeType;

  String? _initialsFromName(String name) {
    final words = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();
    if (words.isEmpty) return null;
    final first = words[0];
    final firstLetter = first.isNotEmpty ? first[0].toUpperCase() : '';
    if (words.length >= 2) {
      final second = words[1];
      final secondLetter = second.isNotEmpty ? second[0].toUpperCase() : '';
      return '$firstLetter$secondLetter';
    }
    return firstLetter.isEmpty ? null : firstLetter;
  }

  bool _isSvg(Object? image) {
    if ((mimeType ?? '').toLowerCase().contains('svg')) return true;
    if (image is String) {
      final path =
          Uri.tryParse(image)?.path.toLowerCase() ?? image.toLowerCase();
      return path.endsWith('.svg');
    }
    return false;
  }

  ImageProvider? _resolveImageProvider(Object? image) {
    if (image == null) return null;
    if (image is ImageProvider) return image;
    if (image is String) {
      final s = image;
      if (s.startsWith('http://') || s.startsWith('https://')) {
        return NetworkImage(s);
      }
      return AssetImage(s);
    }
    if (image is Uint8List) return MemoryImage(image);
    return null;
  }

  Widget _buildSvgContent(
    BuildContext context,
    Object image,
    String? initial,
    Color effectiveBg,
  ) {
    final placeholder = Skeletonizer(
      enabled: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: effectiveBg, shape: BoxShape.circle),
      ),
    );
    final fallback = _buildInitial(
      context,
      initial,
      effectiveBg,
      textColor: AppColors.statIconBlue,
    );

    if (image is Uint8List) {
      return SvgPicture.memory(
        image,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => placeholder,
        errorBuilder: (_, _, _) => fallback,
      );
    }

    if (image is String) {
      final s = image;
      if (s.startsWith('http://') || s.startsWith('https://')) {
        return SvgPicture.network(
          s,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholderBuilder: (_) => placeholder,
          errorBuilder: (_, _, _) => fallback,
        );
      }
      return SvgPicture.asset(
        s,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholderBuilder: (_) => placeholder,
        errorBuilder: (_, _, _) => fallback,
      );
    }

    return fallback;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBg = backgroundColor ?? AppColors.infoBg;
    final effectiveDotColor = statusDotColor ?? AppColors.statIconBlue;
    final initial = _initialsFromName(fallbackInitial ?? '');

    final Widget content;
    if (image != null && _isSvg(image)) {
      content = _buildSvgContent(context, image!, initial, effectiveBg);
    } else {
      final provider = _resolveImageProvider(image);
      content = provider != null
          ? Image(
              image: provider,
              fit: BoxFit.cover,
              width: size,
              height: size,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Skeletonizer(
                  enabled: true,
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: effectiveBg,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
              errorBuilder: (_, _, _) => _buildInitial(
                context,
                initial,
                effectiveBg,
                textColor: AppColors.statIconBlue,
              ),
            )
          : _buildInitial(
              context,
              initial,
              effectiveBg,
              textColor: AppColors.statIconBlue,
            );
    }

    Widget avatar = ClipOval(
      child: ColoredBox(
        color: effectiveBg,
        child: SizedBox(width: size, height: size, child: content),
      ),
    );
    if (border != null) {
      avatar = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, border: border),
        child: avatar,
      );
    }

    if (showStatusDot) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(width: size, height: size, child: avatar),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: effectiveDotColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).canvasColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      );
    }
    return SizedBox(width: size, height: size, child: avatar);
  }

  Widget _buildInitial(
    BuildContext context,
    String? initial,
    Color backgroundColor, {
    Color? textColor,
  }) {
    return Container(
      width: size.w,
      height: size.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initial ?? '?',
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: (size * 0.40).sp,
          color: textColor,
        ),
      ),
    );
  }
}

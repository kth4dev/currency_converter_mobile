import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class AppCacheNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final double? size, width, height, minHeight;
  final BoxFit? fit;

  const AppCacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.borderRadius,
    this.size,
    this.width,
    this.height,
    this.minHeight,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = width ?? size;
    final imageHeight = height ?? size;

    BorderRadius? effectiveBorderRadius = borderRadius ?? BorderRadius.zero;

    Widget buildPlaceholderOrError() {
      return Container(
        height: minHeight,
        decoration: BoxDecoration(
          color: context.colors.surfaceContainerHighest,
          borderRadius: effectiveBorderRadius,
        ),
      );
    }

    Widget cacheImage = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      width: imageWidth,
      height: imageHeight,
      cacheKey: imageUrl,
      maxWidthDiskCache: 1500,
      maxHeightDiskCache: 1500,
      fadeInDuration: const Duration(milliseconds: 250),
      errorWidget: (_, msg, _) {
        return buildPlaceholderOrError();
      },
      placeholder: (context, _) => buildPlaceholderOrError(),
    );

    cacheImage = ClipRRect(
      borderRadius: effectiveBorderRadius,
      child: cacheImage,
    );

    return cacheImage;
  }
}

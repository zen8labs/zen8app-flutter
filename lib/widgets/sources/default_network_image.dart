import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DefaultNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final String placeholder;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit? fit;
  final Alignment alignment;
  const DefaultNetworkImage({
    Key? key,
    this.imageUrl,
    this.placeholder = "images/img_placeholder.png",
    this.width,
    this.height,
    this.radius = 8,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl?.isNotEmpty == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          placeholder: (context, url) => Image.asset(
            placeholder,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
          ),
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          errorWidget: (context, url, error) => Image.asset(
            placeholder,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        placeholder,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      ),
    );
  }
}

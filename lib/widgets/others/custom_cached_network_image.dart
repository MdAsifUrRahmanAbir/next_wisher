import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/dimensions.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.placeHolder,
    this.height,
    this.width,
    this.isCircle = false, this.radius,
    // this.placeHolder
  });

  final String imageUrl;
  final Widget? placeHolder;
  final double? height;
  final double? width;
  final double? radius;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      imageUrl: imageUrl,
      imageBuilder: (context, url) => Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircle
                ? null
                : BorderRadius.circular(Dimensions.radius * (radius ?? 1.2) ),
            image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fill
          )
        ),
      ),
      // fit: BoxFit.fitWidth,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

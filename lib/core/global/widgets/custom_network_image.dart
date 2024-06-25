import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/core/theme/app_colors_light.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
  });

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) => Shimmer(
        gradient: kShimmerGradientColor,
        child: Container(
          color: kTextLightColor,
        ),
      ),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        color: kErrorColor,
        size: 10.h,
      ),
    );
  }
}

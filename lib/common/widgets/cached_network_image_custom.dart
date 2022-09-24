import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:moneylover/theme/suntec_colors.dart';

import '../common.dart';

class CachedImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double width;
  final double height;

  CachedImageNetworkWidget(
      {@required this.imageUrl, this.fit, this.width, this.height});

  final customCacheManage = CacheManager(
    Config("cached_image",
        stalePeriod: UIHelper.duration15day, maxNrOfCacheObjects: 100),
  );
  @override
  Widget build(BuildContext context) {
    if (imageUrl?.isEmpty == true) {
      return SizedBox(
        width: width,
        height: height,
        child: _buildErrorWidget(),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      placeholder: (context, url) => _buildPlaceHolder(),
      errorWidget: (context, url, error) => _buildErrorWidget(),
      cacheManager: customCacheManage,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
    );
  }

  Widget _buildPlaceHolder() {
    return Shimmer.fromColors(
      baseColor: SuntecColor.shimmerBaseColor,
      highlightColor: SuntecColor.shimmerHighlightColor,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      alignment: Alignment.center,
      width: width ?? 100.0,
      height: double.infinity,
      color: SuntecColor.shimmerBaseColor,
      child: const Icon(
        Icons.error,
      ),
    );
  }
}

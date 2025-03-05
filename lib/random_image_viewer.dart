library random_image_viewer;

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RandomImageViewer extends StatefulWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final double? maxScale;
  final double? mimScale;
  final Color? color;
  final Color? errorColor;
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final bool enableZoom;
  final double strokeWidth;
  final double? loaderHeight;
  final double? loaderWidth;
  final IconData? errorIcon;

  const RandomImageViewer({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
    this.onTap,
    this.margin,
    this.radius,
    this.border,
    this.maxScale,
    this.mimScale,
    this.enableZoom = false,
    this.strokeWidth = 4,
    this.loaderHeight,
    this.loaderWidth,
    this.errorColor,
    this.errorIcon,
  });

  @override
  State<RandomImageViewer> createState() => _RandomImageViewerState();
}

class _RandomImageViewerState extends State<RandomImageViewer> {
  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (widget.imagePath?.imageType) {
      case ImageType.svg:
        imageWidget = SvgPicture.asset(
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit ?? BoxFit.contain,
        );
        break;
      case ImageType.file:
        imageWidget = Image.file(
          File(widget.imagePath!),
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode: widget.color != null ? BlendMode.modulate : null,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget(context);
          },
        );
        break;
      case ImageType.network:
        imageWidget = CachedNetworkImage(
          imageUrl: widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode: widget.color != null ? BlendMode.modulate : null,
          placeholder: (context, url) => SizedBox(
            height: widget.loaderHeight,
            width: widget.loaderWidth,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: widget.strokeWidth,
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          errorWidget: (context, url, error) {
            return _buildErrorWidget(context);
          },
        );
        break;
      case ImageType.gif:
        imageWidget = widget.imagePath!.startsWith('http')
            ? Image.network(widget.imagePath!,
            height: widget.height, width: widget.width, fit: widget.fit ?? BoxFit.contain)
            : Image.asset(widget.imagePath!,
            height: widget.height, width: widget.width, fit: widget.fit ?? BoxFit.contain);
        break;
      case ImageType.webp:
      case ImageType.bmp:
      case ImageType.tiff:
      case ImageType.ico:
      case ImageType.heic:
      case ImageType.jpg:
      case ImageType.jpeg:
      case ImageType.png:
      default:
        imageWidget = Image.asset(
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode: widget.color != null ? BlendMode.modulate : null,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget(context);
          },
        );
    }

    if (widget.enableZoom) {
      imageWidget = InteractiveViewer(
        maxScale: widget.maxScale ?? 2.0,
        minScale: widget.mimScale ?? 0.8,
        child: imageWidget,
      );
    }

    Widget tappableImage = GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: imageWidget,
      ),
    );

    Widget paddedImage = Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: tappableImage,
    );

    return widget.alignment != null
        ? Align(
      alignment: widget.alignment!,
      child: _buildCircleImage(context, paddedImage),
    )
        : _buildCircleImage(context, paddedImage);
  }

  Widget _buildCircleImage(BuildContext context, Widget imageWidget) {
    return widget.radius != null
        ? ClipRRect(
      borderRadius: widget.radius!,
      child: _buildImageWithBorder(context, imageWidget),
    )
        : _buildImageWithBorder(context, imageWidget);
  }

  Widget _buildImageWithBorder(BuildContext context, Widget imageWidget) {
    if (widget.imagePath == null || widget.imagePath!.isEmpty) {
      return _buildErrorWidget(context);
    } else {
      return widget.border != null
          ? Container(
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: widget.radius,
        ),
        child: imageWidget,
      )
          : imageWidget;
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: Icon(widget.errorIcon, color: widget.errorColor ?? Colors.red, size: 48),
      ),
    );
  }
}

extension ImageTypeExtension on String? {
  ImageType get imageType {
    if (this == null || this!.isEmpty) return ImageType.unknown;
    if (this!.startsWith('http') || this!.startsWith('https')) {
      if (this!.endsWith('.svg')) return ImageType.svg;
      if (this!.endsWith('.jpg') || this!.endsWith('.jpeg')) return ImageType.jpeg;
      if (this!.endsWith('.png')) return ImageType.png;
      if (this!.endsWith('.gif')) return ImageType.gif;
      if (this!.endsWith('.webp')) return ImageType.webp;
      if (this!.endsWith('.bmp')) return ImageType.bmp;
      if (this!.endsWith('.tiff') || this!.endsWith('.tif')) return ImageType.tiff;
      if (this!.endsWith('.ico')) return ImageType.ico;
      if (this!.endsWith('.heic') || this!.endsWith('.heif')) return ImageType.heic;
      return ImageType.network;
    } else if (this!.startsWith('/data/user/0/')) {
      return ImageType.file;
    } else {
      if (this!.endsWith('.svg')) return ImageType.svg;
      if (this!.endsWith('.jpg') || this!.endsWith('.jpeg')) return ImageType.jpeg;
      if (this!.endsWith('.png')) return ImageType.png;
      if (this!.endsWith('.gif')) return ImageType.gif;
      if (this!.endsWith('.webp')) return ImageType.webp;
      if (this!.endsWith('.bmp')) return ImageType.bmp;
      if (this!.endsWith('.tiff') || this!.endsWith('.tif')) return ImageType.tiff;
      if (this!.endsWith('.ico')) return ImageType.ico;
      if (this!.endsWith('.heic') || this!.endsWith('.heif')) return ImageType.heic;
      return ImageType.unknown;
    }
  }
}

enum ImageType { svg, png, jpg, jpeg, gif, webp, bmp, tiff, ico, heic, network, file, unknown }



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
  final BoxFit? fit;
  final Alignment? alignment;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;
  final String placeHolder;
  final bool enableZoom;
  final double strokeWidth;
  final double? loaderHeight;
  final double? loaderWidth;

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
    this.placeHolder = 'assets/images/svg/logo.svg',
    this.enableZoom = false,
    this.strokeWidth = 4, this.loaderHeight, this.loaderWidth,
    // this.scale,
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
        imageWidget = widget.enableZoom
            ? InteractiveViewer(
          maxScale: widget.maxScale ?? 2.0,
          minScale: widget.mimScale ?? 0.8,
          child: SvgPicture.asset(
            widget.imagePath!,
            height: widget.height,
            width: widget.width,
            color: widget.color,
            fit: widget.fit ?? BoxFit.contain,
          ),
        )
            : SvgPicture.asset(
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          color: widget.color,
          fit: widget.fit ?? BoxFit.contain,
        );
        break;
      case ImageType.file:
        imageWidget = widget.enableZoom
            ? InteractiveViewer(
          maxScale: widget.maxScale ?? 2.0,
          minScale: widget.mimScale ?? 0.8,
          child: Image.file(
            File(widget.imagePath!),
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.contain,
            color: widget.color,
            colorBlendMode:
            widget.color != null ? BlendMode.modulate : null,
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorWidget(context);
            },
          ),
        )
            : Image.file(
          // scale: widget.scale!,
          File(widget.imagePath!),
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode:
          widget.color != null ? BlendMode.modulate : null,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget(context);
          },
        );
        break;
      case ImageType.network:
        imageWidget = widget.enableZoom
            ? InteractiveViewer(
          maxScale: widget.maxScale ?? 2.0,
          minScale: widget.mimScale ?? 0.8,
          child: CachedNetworkImage(
            imageUrl: widget.imagePath!,
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.contain,
            color: widget.color,
            colorBlendMode: widget.color != null
                ? BlendMode.modulate
                : null, // Replacement
            placeholder: (context, url) =>
                SizedBox(
                  height: widget.loaderHeight,
                  width: widget.loaderWidth,
                  child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                        strokeWidth: widget.strokeWidth,
                        strokeCap: StrokeCap.round,
                      )),
                ),
            errorWidget: (context, url, error) {
              return _buildErrorWidget(context);
            },
          ),
        )
            : CachedNetworkImage(
          imageUrl: widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode: widget.color != null
              ? BlendMode.modulate
              : null,
          placeholder: (context, url) =>
              SizedBox(
                height: widget.loaderHeight,
                width: widget.loaderWidth,
                child: Center(child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: widget.strokeWidth,
                  strokeCap: StrokeCap.round,
                )),
              ),
          errorWidget: (context, url, error) {
            return _buildErrorWidget(context);
          },
        );
        break;
      case ImageType.jpg:
        imageWidget = widget.enableZoom
            ? InteractiveViewer(
          maxScale: widget.maxScale ?? 2.0,
          minScale: widget.mimScale ?? 0.8,
          child: Image.asset(
            // scale: widget.scale!,
            widget.imagePath!,
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.contain,
            color: widget.color,
            colorBlendMode:
            widget.color != null ? BlendMode.modulate : null,
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorWidget(context);
            },
          ),
        )
            : Image.asset(
          // scale: widget.scale!,
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode:
          widget.color != null ? BlendMode.modulate : null,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget(context);
          },
        );
        break;
      case ImageType.jpeg:
        imageWidget = widget.enableZoom
            ? InteractiveViewer(
          maxScale: widget.maxScale ?? 2.0,
          minScale: widget.mimScale ?? 0.8,
          child: Image.asset(
            // scale: widget.scale!,
            widget.imagePath!,
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.contain,
            color: widget.color,
            colorBlendMode:
            widget.color != null ? BlendMode.modulate : null,
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorWidget(context);
            },
          ),
        )
            : Image.asset(
          // scale: widget.scale!,
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode:
          widget.color != null ? BlendMode.modulate : null,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget(context);
          },
        );
        break;
      case ImageType.png:
      default:
        imageWidget = widget.enableZoom
            ? InteractiveViewer(
          maxScale: widget.maxScale ?? 2.0,
          minScale: widget.mimScale ?? 0.8,
          child: Image.asset(
            // scale: widget.scale!,
            widget.imagePath!,
            height: widget.height,
            width: widget.width,
            fit: widget.fit ?? BoxFit.contain,
            color: widget.color,
            colorBlendMode:
            widget.color != null ? BlendMode.modulate : null,
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorWidget(context);
            },
          ),
        )
            : Image.asset(
          // scale: widget.scale!,
          widget.imagePath!,
          height: widget.height,
          width: widget.width,
          fit: widget.fit ?? BoxFit.contain,
          color: widget.color,
          colorBlendMode:
          widget.color != null ? BlendMode.modulate : null,
          errorBuilder: (context, error, stackTrace) {
            return _buildErrorWidget(context);
          },
        );
    }

    Widget paddedImage = Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: imageWidget,
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
        child: Icon(Icons.error, color: Colors.red, size: 48,),
      ),
    );
  }
}

extension ImageTypeExtension on String? {
  ImageType get imageType {
    if (this == null || this!.isEmpty) return ImageType.unknown;
    if (this!.startsWith('http') || this!.startsWith('https')) {
      // Assume network for URLs, and check extension for more precision
      if (this!.endsWith('.svg')) {
        return ImageType.svg;
      } else if (this!.endsWith('.jpg') || this!.endsWith('.jpeg')) {
        return ImageType.jpeg;
      } else if (this!.endsWith('.png')) {
        return ImageType.png;
      } else {
        return ImageType.network;
      }
    } else if (this!.startsWith('/data/user/0/')) {
      return ImageType.file;
    } else if (this!.endsWith('.svg')) {
      return ImageType.svg;
    } else if (this!.endsWith('.jpg') || this!.endsWith('.jpeg')) {
      return ImageType.jpeg;
    } else if (this!.endsWith('.png')) {
      return ImageType.png;
    } else {
      return ImageType.unknown;
    }
  }
}


enum ImageType { svg, png, jpg, jpeg, network, file, unknown }




// class RandomImageViewer extends StatefulWidget {
//   final String? imagePath;
//   final String? errorImagePath;
//   final double? height;
//   final double? width;
//   final double? maxScale;
//   final double? mimScale;
//   final Color? imageColor;
//   final Color progressIndicatorColor;
//   final BoxFit? fit;
//   final Alignment? alignment;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry? margin;
//   final BorderRadius? radius;
//   final BoxBorder? border;
//   final bool enableZoom;
//   final double strokeWidth;
//   final double? loaderHeight;
//   final double? loaderWidth;
//
//   const RandomImageViewer({
//     super.key,
//     this.imagePath,
//     this.errorImagePath,
//     this.height,
//     this.width,
//     this.imageColor,
//     this.fit,
//     this.alignment,
//     this.onTap,
//     this.margin,
//     this.radius,
//     this.border,
//     this.maxScale,
//     this.mimScale,
//     this.enableZoom = false,
//     this.strokeWidth = 4,
//     this.loaderHeight,
//     this.loaderWidth,
//     this.progressIndicatorColor = Colors.blue,
//   });
//
//   @override
//   State<RandomImageViewer> createState() => _RandomImageViewerState();
// }
//
// class _RandomImageViewerState extends State<RandomImageViewer> {
//   Widget _wrapWithZoom(Widget child) {
//     return widget.enableZoom
//         ? InteractiveViewer(
//       maxScale: widget.maxScale ?? 2.0,
//       minScale: widget.mimScale ?? 0.8,
//       child: child,
//     )
//         : child;
//   }
//
//   Widget _buildSvgImage(String path) {
//     try {
//       if (path.startsWith('http')) {
//         return _wrapWithZoom(
//           SvgPicture.network(
//             path,
//             height: widget.height,
//             width: widget.width,
//             colorFilter: widget.imageColor != null
//                 ? ColorFilter.mode(widget.imageColor!, BlendMode.srcIn)
//                 : null,
//             fit: widget.fit ?? BoxFit.contain,
//             placeholderBuilder: (BuildContext context) => _buildLoader(),
//           ),
//         );
//       } else if (path.startsWith('/')) {
//         return _wrapWithZoom(
//           SvgPicture.file(
//             File(path),
//             height: widget.height,
//             width: widget.width,
//             colorFilter: widget.imageColor != null
//                 ? ColorFilter.mode(widget.imageColor!, BlendMode.srcIn)
//                 : null,
//             fit: widget.fit ?? BoxFit.contain,
//           ),
//         );
//       } else {
//         return _wrapWithZoom(
//           SvgPicture.asset(
//             path,
//             height: widget.height,
//             width: widget.width,
//             colorFilter: widget.imageColor != null
//                 ? ColorFilter.mode(widget.imageColor!, BlendMode.srcIn)
//                 : null,
//             fit: widget.fit ?? BoxFit.contain,
//           ),
//         );
//       }
//     } catch (e) {
//       return _buildErrorWidget();
//     }
//   }
//
//   Widget _buildNetworkImage(String path) {
//     return _wrapWithZoom(
//       CachedNetworkImage(
//         imageUrl: path,
//         height: widget.height,
//         width: widget.width,
//         fit: widget.fit ?? BoxFit.contain,
//         color: widget.imageColor,
//         colorBlendMode: widget.imageColor != null ? BlendMode.modulate : null,
//         placeholder: (context, url) => _buildLoader(),
//         errorWidget: (context, url, error) => _buildErrorWidget(),
//       ),
//     );
//   }
//
//   Widget _buildFileImage(String path) {
//     return _wrapWithZoom(
//       Image.file(
//         File(path),
//         height: widget.height,
//         width: widget.width,
//         fit: widget.fit ?? BoxFit.contain,
//         color: widget.imageColor,
//         colorBlendMode: widget.imageColor != null ? BlendMode.modulate : null,
//         errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
//       ),
//     );
//   }
//
//   Widget _buildAssetImage(String path) {
//     return _wrapWithZoom(
//       Image.asset(
//         path,
//         height: widget.height,
//         width: widget.width,
//         fit: widget.fit ?? BoxFit.contain,
//         color: widget.imageColor,
//         colorBlendMode: widget.imageColor != null ? BlendMode.modulate : null,
//         errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
//       ),
//     );
//   }
//
//   Widget _buildLoader() {
//     return SizedBox(
//       height: widget.loaderHeight,
//       width: widget.loaderWidth,
//       child: Center(
//         child: CircularProgressIndicator(
//           color: widget.progressIndicatorColor,
//           strokeWidth: widget.strokeWidth,
//           strokeCap: StrokeCap.round,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildErrorWidget() {
//     return Container(
//       height: widget.height,
//       width: widget.width,
//       alignment: Alignment.center,
//       child: widget.errorImagePath != null && widget.errorImagePath!.isNotEmpty
//           ? Image.asset(
//         widget.errorImagePath!,
//         height: widget.height,
//         width: widget.width,
//         fit: BoxFit.contain,
//       )
//           : Icon(
//         Icons.error_outline,
//         size: 48.0,
//         color: Theme.of(context).colorScheme.error,
//       ),
//     );
//   }
//
//   ImageType _getImageType(String path) {
//     if (path.startsWith('http')) {
//       if (path.toLowerCase().endsWith('.svg')) {
//         return ImageType.svg;
//       }
//       return ImageType.network;
//     }
//     if (path.startsWith('/')) {
//       if (path.toLowerCase().endsWith('.svg')) {
//         return ImageType.svg;
//       }
//       return ImageType.file;
//     }
//     if (path.toLowerCase().endsWith('.svg')) {
//       return ImageType.svg;
//     }
//     if (path.toLowerCase().endsWith('.png')) {
//       return ImageType.png;
//     }
//     if (path.toLowerCase().endsWith('.jpg') || path.toLowerCase().endsWith('.jpeg')) {
//       return ImageType.jpeg;
//     }
//     return ImageType.unknown;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.imagePath == null || widget.imagePath!.isEmpty) {
//       return _buildErrorWidget();
//     }
//
//     final path = widget.imagePath!;
//     final type = _getImageType(path);
//
//     Widget imageWidget;
//
//     switch (type) {
//       case ImageType.svg:
//         imageWidget = _buildSvgImage(path);
//         break;
//       case ImageType.network:
//         imageWidget = _buildNetworkImage(path);
//         print("This is image path =========>>> ${path}");
//         break;
//       case ImageType.file:
//         imageWidget = _buildFileImage(path);
//         break;
//       case ImageType.png:
//       case ImageType.jpeg:
//       case ImageType.unknown:
//         imageWidget = _buildAssetImage(path);
//         break;
//     }
//
//     if (widget.onTap != null) {
//       imageWidget = GestureDetector(
//         onTap: widget.onTap,
//         child: imageWidget,
//       );
//     }
//
//     imageWidget = Padding(
//       padding: widget.margin ?? EdgeInsets.zero,
//       child: imageWidget,
//     );
//
//     if (widget.radius != null || widget.border != null) {
//       imageWidget = Container(
//         decoration: BoxDecoration(
//           border: widget.border,
//           borderRadius: widget.radius,
//         ),
//         child: ClipRRect(
//           borderRadius: widget.radius ?? BorderRadius.zero,
//           child: imageWidget,
//         ),
//       );
//     }
//
//     return widget.alignment != null
//         ? Align(alignment: widget.alignment!, child: imageWidget)
//         : imageWidget;
//   }
// }
//
// enum ImageType { svg, png, jpeg, network, file, unknown }
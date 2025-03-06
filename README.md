# Random Image Viewer 

Random Image Viewer is a powerful and highly customizable Flutter widget that allows developers to effortlessly display images from various sources, including local assets, files, and network URLs. This widget supports multiple image formats and provides built-in zooming, error handling, caching, borders, tap detection, and customization options, making it an all-in-one solution for managing images in Flutter apps.

## 🌟 Features
✅ Supports Multiple Image Formats
Display images in various formats with full compatibility:

Vector & Raster Images: SVG, PNG, JPG, JPEG
Animated & Web Optimized: GIF, WebP
High-Quality & Professional Formats: BMP, TIFF, ICO, HEIC
Network & Local Image Handling

✅ Interactive Zooming
Enable zooming with InteractiveViewer for SVG, PNG, JPG, JPEG, WebP, GIF, BMP, TIFF, ICO, HEIC, and network images
Control zoom levels using maxScale and minScale properties

✅ Custom Error Handling
Display a custom error icon and error color when an image fails to load
Fully customizable error widget using errorIcon and errorColor

✅ Gesture Support
Add a tap gesture with the onTap callback
Detect user interactions effortlessly

✅ Fully Customizable
Modify appearance with:
Height & Width (responsive sizing)
BoxFit Options (contain, cover, fill, etc.)
Borders & Border Radius (for rounded images)
Alignment & Margins (for positioning)

✅ Optimized Performance with Caching
Uses CachedNetworkImage for efficient network image caching
Reduces redundant loading and improves performance

## 📌 Installation

Add the package to your pubspec.yaml file:

```yaml
dependencies:
  random_image_viewer: latest_version
```

Then, run `flutter pub get` to install the package.

## 🚀 Usage Examples

To use Random Image Viewer in your Flutter app, first import the package:

```dart
import 'package:random_image_viewer/random_image_viewer.dart';
```

before we dive into the details, you should know that you can use Random Image Viewer in different ways:

📌 Displaying Local & Network Images

```dart
RandomImageViewer(
  imagePath: "assets/images/sample.png", // Local asset image
  height: 200,
  width: 200,
  fit: BoxFit.cover,
)

```

```dart
RandomImageViewer(
  imagePath: "https://www.example.com/sample.jpg", // Network image
  height: 200,
  width: 200,
  enableZoom: true, // Enable zooming
)
```

📌 Displaying Various Image Formats

GIF

```dart
RandomImageViewer(
enableZoom: true,
maxScale: 200,
height: 200,
imagePath: "assets/images/gif.gif",
),
```

BMP (Local)

```dart
RandomImageViewer(
  imagePath: "assets/images/sample.bmp",
  height: 200,
  width: 200,
)
```

TIFF (Local)

```dart
RandomImageViewer(
  imagePath: "assets/images/sample.tiff",
  height: 200,
  width: 200,
)
```

Try the remaining by yourself with different properties/parameters

## 📌 Handling Errors Gracefully

```dart
RandomImageViewer(
  imagePath: "invalid/path/to/image.jpg", // Invalid path
  height: 200,
  width: 200,
  errorIcon: Icons.broken_image,
  errorColor: Colors.red,
)
```

## 🎯 Customization Options

| Property         | Description |
|-----------------|-------------|
| `imagePath`     | Path to the image (asset, file, or network URL) |
| `height` & `width` | Define image dimensions |
| `fit`           | Control image fitting (`BoxFit.contain`, `BoxFit.cover`, etc.) |
| `enableZoom`    | Enable pinch-to-zoom (`true/false`) |
| `maxScale` & `minScale` | Define zoom levels for InteractiveViewer |
| `onTap`         | Callback when image is tapped |
| `margin`        | Adds padding around the image |
| `border`        | Adds a border around the image |
| `radius`        | Adds rounded corners |
| `errorIcon`     | Custom icon to show when the image fails to load |
| `errorColor`    | Custom color for the error icon |
| `loaderHeight` & `loaderWidth` | Customize loading indicator size |
| `strokeWidth`   | Adjusts the thickness of the loader |


## 🔗 Related Packages

- `cached_network_image` → Used for caching network images
- `flutter_svg` → Used for displaying SVG images

## 📄 License
This package is open-source and available under the MIT License.

## 🚀 Perfect for Any Flutter App!

Whether you're building an e-commerce app, a social media feed, or a document viewer, Random Image Viewer makes handling images simple and efficient.

Let me know if you need any modifications! 😊


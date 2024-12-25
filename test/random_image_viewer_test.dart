import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:random_image_viewer/random_image_viewer.dart';

void main() {
  testWidgets('RandomImageViewer shows network image', (WidgetTester tester) async {
    const imagePath = 'https://example.com/image.png';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RandomImageViewer(
            imagePath: imagePath,
          ),
        ),
      ),
    );

    // Verify that the CachedNetworkImage is displayed
    expect(find.byType(CachedNetworkImage), findsOneWidget);
  });

  testWidgets('RandomImageViewer shows error icon when no image path', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RandomImageViewer(
            imagePath: null,
          ),
        ),
      ),
    );

    // Verify that the error icon is displayed
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
  });
}

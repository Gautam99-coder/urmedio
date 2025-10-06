// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Assuming your main app class is defined in 'package:urmedio/main.dart'
import 'package:urmedio/main.dart';

void main() {
  testWidgets('App starts without errors (Smoke Test)', (WidgetTester tester) async {
    // Build our app using the correct class name: UrMedioApp
    await tester.pumpWidget(const UrMedioApp());

    // You can now verify that key elements of your initial screen (SplashScreen or Onboarding) load correctly.
    // Since this is a smoke test, we'll just check for the MaterialApp to confirm the build works.
    expect(find.byType(MaterialApp), findsOneWidget);
    
    // NOTE: The original counter test logic below is for the default app template.
    // It is commented out as it won't apply to your app structure (which starts with SplashScreen).
    
    /*
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    */
  });
}
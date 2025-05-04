// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smart_feng_shui/main.dart';

void main() {
  testWidgets('App smoke test - basic structure', (WidgetTester tester) async {
    // Mock SharedPreferences for testing
    SharedPreferences.setMockInitialValues({
      'skip_login': true,
    });
    
    // Get instance of mocked SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    
    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp(prefs: prefs, skipLogin: true));

    // Wait for any animations or async operations to complete
    await tester.pumpAndSettle();
    
    // Basic verification that the app structure builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

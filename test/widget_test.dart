import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kkr_fan_page/main.dart';

void main() {
  testWidgets('KKR Fan Page loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(NewsApp());

    // Verify that the KKR Fan Page title is present
    expect(find.text('KKR Fan Page'), findsOneWidget);
    
    // Verify that the navigation tabs are present
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Shop'), findsOneWidget);
    expect(find.text('Matches'), findsOneWidget);
    expect(find.text('Players'), findsOneWidget);
    expect(find.text('Favorites'), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    await tester.pumpWidget(NewsApp());

    // Tap on Shop tab
    await tester.tap(find.text('Shop'));
    await tester.pumpAndSettle();

    // Verify we're on the shop page
    expect(find.text('KKR Shop'), findsOneWidget);

    // Tap on Matches tab
    await tester.tap(find.text('Matches'));
    await tester.pumpAndSettle();

    // Verify we're on the matches page
    expect(find.text('KKR Matches'), findsOneWidget);

    // Tap on Players tab
    await tester.tap(find.text('Players'));
    await tester.pumpAndSettle();

    // Verify we're on the players page
    expect(find.text('KKR Players'), findsOneWidget);
  });
}

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:teqmavens/main.dart';

void main() {
  testWidgets('dashboard renders the travel discovery flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TravelApp());

    expect(find.text('Good Morning'), findsOneWidget);
    expect(find.text('Prabhat'), findsOneWidget);
    expect(find.text('Toronto, Canada'), findsAtLeastNWidgets(1));
    expect(find.text('Recommended for you'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Alice Premium'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
  });
}

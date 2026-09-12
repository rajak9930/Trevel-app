// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:teqmavens/main.dart';
import 'package:teqmavens/widgets/remote_image.dart';

void main() {
  testWidgets('dashboard renders the travel discovery flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TravelApp());

    expect(find.textContaining('Good '), findsOneWidget);
    expect(find.text('Prabhat'), findsOneWidget);
    expect(find.text('Toronto, Canada'), findsAtLeastNWidgets(1));
    expect(find.text('Recommended for you'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('Alice Premium'), findsOneWidget);
    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);

    // Close drawer
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    // Switch to Hotels Resort (Tab 1)
    await tester.tap(find.byIcon(Icons.flight_takeoff_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Hotels Resort'), findsAtLeastNWidgets(1));
    expect(find.text('Choose your next stay'), findsOneWidget);
    expect(find.text('Toronto, Canada'), findsAtLeastNWidgets(1));

    // Switch to Booking Hotel (Tab 2)
    await tester.tap(find.byIcon(Icons.calendar_month_outlined));
    await tester.pumpAndSettle();
    expect(find.text('2-night stay'), findsOneWidget);
    expect(find.text('Feb 2026'), findsOneWidget);
    expect(find.text('Cancel Date'), findsOneWidget);

    // Switch to Account (Tab 3)
    await tester.tap(find.byType(RemoteAvatar).last);
    await tester.pumpAndSettle();
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.text('Privacy & Security'), findsOneWidget);
    expect(find.text('Coming Soon'), findsOneWidget);
  });
}

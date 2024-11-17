import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodish_app/food_screen.dart'; // Update the import path to match your project structure

void main() {
  testWidgets('Food App smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home:
            FoodScreen(), // Wrap FoodScreen in MaterialApp for proper rendering
      ),
    );

    // Verify that FoodScreen is displayed.
    expect(find.byType(FoodScreen), findsOneWidget);

    // Verify that the DropdownButton is displayed.
    expect(find.byType(DropdownButton<String>), findsOneWidget);

    // Verify that the CircularProgressIndicator is displayed initially (image loading state).
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Simulate selecting a category in the dropdown.
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle(); // Wait for the dropdown animation to finish
    await tester.tap(find.text('pizza').last); // Select the 'pizza' category
    await tester.pump();

    // Verify that the selected category triggers an image fetch and removes the loading indicator.
    expect(find.byType(CircularProgressIndicator),
        findsNothing); // Ensure loading is complete
    expect(find.byType(Image), findsOneWidget); // Ensure the image is displayed
  });
}

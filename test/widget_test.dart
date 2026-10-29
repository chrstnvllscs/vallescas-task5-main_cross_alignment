import 'package:flutter_test/flutter_test.dart';
import 'package:vallescas_task5_main_cross_alignment/main.dart';

void main() {
  testWidgets('App renders with Black AppBar displaying VALLESCAS', (WidgetTester tester) async {
    await tester.pumpWidget(const MainCrossAlignmentApp());

    // 1. Verify AppBar title contains user's lastname VALLESCAS
    expect(find.text('TASK 5 - VALLESCAS'), findsOneWidget);

    // 2. Verify default alignment property is MainAxisAlignment.center
    expect(find.text('MainAxisAlignment.center'), findsWidgets);

    // 3. Verify Row and Column toggle buttons exist
    expect(find.text('Row'), findsOneWidget);
    expect(find.text('Column'), findsOneWidget);

    // 4. Verify MainAxis and CrossAxis toggle buttons exist
    expect(find.text('MainAxis'), findsOneWidget);
    expect(find.text('CrossAxis'), findsOneWidget);

    // 5. Verify navigation buttons
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Previous'), findsOneWidget);

    // 6. Test cycling through MainAxisAlignment options
    final mainAxisProperties = [
      'MainAxisAlignment.spaceAround',
      'MainAxisAlignment.spaceBetween',
      'MainAxisAlignment.spaceEvenly',
      'MainAxisAlignment.start',
      'MainAxisAlignment.end',
      'MainAxisAlignment.center',
    ];

    for (final prop in mainAxisProperties) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text(prop), findsWidgets);
    }

    // 7. Test switching to CrossAxisAlignment
    await tester.tap(find.text('CrossAxis'));
    await tester.pumpAndSettle();
    expect(find.text('CrossAxisAlignment.start'), findsWidgets);

    // 8. Test cycling through CrossAxisAlignment options
    final crossAxisProperties = [
      'CrossAxisAlignment.end',
      'CrossAxisAlignment.baseline',
      'CrossAxisAlignment.center',
      'CrossAxisAlignment.stretch',
    ];

    for (final prop in crossAxisProperties) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text(prop), findsWidgets);
    }

    // 9. Test switching to Column widget
    await tester.tap(find.text('Column'));
    await tester.pumpAndSettle();
    expect(find.text('CrossAxisAlignment.stretch'), findsWidgets);

    // 10. Test toggling Grid Overview mode
    await tester.tap(find.byTooltip('All Examples Overview'));
    await tester.pumpAndSettle();
    expect(find.text('Row Widget Examples'), findsOneWidget);
    expect(find.text('Column Widget Examples'), findsOneWidget);

    // 11. Test toggling back to Single View
    await tester.tap(find.byTooltip('Single View'));
    await tester.pumpAndSettle();

    // 12. Test Clean Screenshot Mode
    await tester.tap(find.byTooltip('Clean Screenshot Mode'));
    await tester.pumpAndSettle();
    // In clean mode, the bottom control panel is hidden
    expect(find.text('Next'), findsNothing);
  });
}

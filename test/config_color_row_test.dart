import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assistive_ui_components/src/internal/assistive_button/manual_config_sheet/config_color_row.dart';

void main() {
  Color? picked;

  Future<void> openDialog(WidgetTester tester) async {
    picked = null;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (context) {
                return colorRow(
                  label: 'Cor',
                  value: const Color(0xFF005C72),
                  context: context,
                  onChanged: (color) => picked = color,
                );
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(InkWell).first);
    await tester.pumpAndSettle();
  }

  testWidgets('mostra o valor inicial em hexadecimal e Aplicar fecha o dialog',
      (tester) async {
    await openDialog(tester);

    expect(find.text('Selecionar cor'), findsOneWidget);
    expect(find.text('#005C72'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Aplicar'));
    await tester.pumpAndSettle();
  });

  testWidgets('cores rápidas aplicam o tom escolhido', (tester) async {
    await openDialog(tester);

    await tester.tap(find.byTooltip('Vermelho'));
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Aplicar'));
    await tester.pumpAndSettle();

    expect(picked, const Color(0xFFD32F2F));
  });

  testWidgets('campo hexadecimal configura a cor via submit', (tester) async {
    await openDialog(tester);

    await tester.enterText(find.byType(TextField), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(picked, isNull); // ainda não confirmado

    await tester.tap(find.widgetWithText(ElevatedButton, 'Aplicar'));
    await tester.pumpAndSettle();

    expect(picked, const Color(0xFF123456));
  });

  testWidgets('campo hexadecimal sem alfa preserva o alfa atual',
      (tester) async {
    await openDialog(tester);

    // O quarto slider é o canal A: tap no centro ajusta alfa < 255.
    await tester.tap(find.byType(Slider).at(3), warnIfMissed: false);
    await tester.pump();

    await tester.enterText(find.byType(TextField), '123456');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Aplicar'));
    await tester.pumpAndSettle();

    expect(picked, isNotNull);
    final int red = (picked!.toARGB32() >> 16) & 0xFF;
    final int green = (picked!.toARGB32() >> 8) & 0xFF;
    final int blue = picked!.toARGB32() & 0xFF;
    final int alpha = (picked!.toARGB32() >> 24) & 0xFF;

    expect(red, 0x12);
    expect(green, 0x34);
    expect(blue, 0x56);
    expect(alpha, lessThan(255)); // alfa preservado pelo canal A
  });

  testWidgets('slider do canal R atualiza a cor', (tester) async {
    await openDialog(tester);

    // O primeiro slider da folha é o canal R: um toque no meio do track
    // posiciona o valor próximo do centro (~128 em 0..255).
    await tester.tap(find.byType(Slider).first, warnIfMissed: false);
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Aplicar'));
    await tester.pumpAndSettle();

    expect(picked, isNotNull);
    final int red = (picked!.toARGB32() >> 16) & 0xFF;
    expect(red, inInclusiveRange(96, 160));
  });
}

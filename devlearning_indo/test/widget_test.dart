// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:devlearning_indo/main.dart';

void main() {
  testWidgets('checkbox persetujuan mengubah pesan status', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(
      find.text('Saya menyetujui semua persyaratan yang berlaku'),
      findsOneWidget,
    );
    expect(find.text('Anda belum bisa melanjutkan'), findsOneWidget);
    expect(find.text('Lanjutkan pendaftaran diperbolehkan'), findsNothing);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(find.text('Anda belum bisa melanjutkan'), findsNothing);
    expect(
      find.text('Lanjutkan pendaftaran diperbolehkan'),
      findsOneWidget,
    );
  });

  testWidgets('switch mengubah mode terang dan gelap', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Aktifkan Mode Gelap'), findsOneWidget);
    expect(find.text('Mode Terang Aktif'), findsOneWidget);
    expect(find.text('Mode Gelap Aktif'), findsNothing);
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      Colors.white,
    );

    await tester.tap(find.byType(Switch));
    await tester.pump();

    expect(find.text('Mode Terang Aktif'), findsNothing);
    expect(find.text('Mode Gelap Aktif'), findsOneWidget);
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      Colors.grey[900],
    );
  });

  testWidgets('dropdown menampilkan kategori yang dipilih', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Pilih Kategori Produk'), findsWidgets);
    expect(find.text('Anda memilih kategori: Makanan'), findsNothing);

    await tester.tap(find.byType(DropdownMenu<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Makanan').last);
    await tester.pumpAndSettle();

    expect(find.text('Anda memilih kategori: Makanan'), findsOneWidget);
  });
}

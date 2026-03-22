
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/ana_sayfa.dart';
import 'models/bitki_model.dart';
import 'pages/bitki_detay_sayfasi.dart';
import 'pages/bitki_listesi_sayfasi.dart';
import 'pages/foto_tarama_sayfasi.dart';
import 'models/toprak_model.dart';
import 'pages/sonuc_sayfasi.dart';
import 'pages/toprak_detay_sayfasi.dart';
import 'pages/toprak_listesi_sayfasi.dart';
import 'ui/app_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase henüz bağlanmadıysa uygulama yine açılır.
  }
  runApp(const TarimAsistanApp());
}

class TarimAsistanApp extends StatelessWidget {
  const TarimAsistanApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTheme = ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFF4F9F4),
      colorScheme: ColorScheme.fromSeed(
        seedColor: TarimUi.leaf,
        brightness: Brightness.light,
        primary: TarimUi.forest,
        secondary: TarimUi.mint,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      useMaterial3: false,
    );

    return MaterialApp(
      title: 'Tarım Asistan',
      debugShowCheckedModeBanner: false,
      theme: baseTheme,
      initialRoute: AnaSayfa.routeName,
      routes: {
        AnaSayfa.routeName: (context) => const AnaSayfa(),
        ToprakListesiSayfasi.routeName: (context) =>
            const ToprakListesiSayfasi(),
        BitkiListesiSayfasi.routeName: (context) =>
            const BitkiListesiSayfasi(),
        FotoTaramaSayfasi.routeName: (context) => const FotoTaramaSayfasi(),
      },
      // Dinamik argüman gerektiren route'lar için onGenerateRoute
      onGenerateRoute: (settings) {
        if (settings.name == ToprakDetaySayfasi.routeName) {
          final toprak = settings.arguments as ToprakModel;
          return MaterialPageRoute(
            builder: (_) => ToprakDetaySayfasi(toprak: toprak),
          );
        }
        if (settings.name == BitkiDetaySayfasi.routeName) {
          final bitki = settings.arguments as BitkiModel;
          return MaterialPageRoute(
            builder: (_) => BitkiDetaySayfasi(bitki: bitki),
          );
        }
        if (settings.name == SonucSayfasi.routeName &&
            settings.arguments is SonucSayfasiArgs) {
          final args = settings.arguments as SonucSayfasiArgs;
          return MaterialPageRoute(
            builder: (_) => SonucSayfasi(
              args: args,
            ),
          );
        }
        return null;
      },
    );
  }
}


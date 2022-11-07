import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osmosis/views/home.dart';

void main() {
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Osmosis',
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.latoTextTheme(),
          backgroundColor: Colors.black87),
      home: const Home(),
      debugShowCheckedModeBanner: kDebugMode,
      supportedLocales: const [Locale('en')],
    );
  }
}

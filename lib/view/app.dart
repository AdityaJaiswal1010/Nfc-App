import 'dart:io';

import 'package:app/repository/repository.dart';
import 'package:app/view/about.dart';
import 'package:app/view/common/form_row.dart';
import 'package:app/view/ndef_format.dart';
import 'package:app/view/ndef_write.dart';
import 'package:app/view/ndef_write_lock.dart';
import 'package:app/view/tag_read.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  static Future<Widget> withDependency() async {
    final repo = await Repository.createInstance();
    return MultiProvider(
      providers: [
        Provider<Repository>.value(
          value: repo,
        ),
      ],
      
      child: App(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _Home(),
      theme: _themeData(Brightness.light),
      darkTheme: _themeData(Brightness.dark),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Center(
          child: Row(
            children: [
              Icon(FontAwesomeIcons.nfcSymbol),
              Text('  NFC Project',textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(2),
        children: [
          FormSection(children: [
            FormSection(
              children: [
                FormRow(
                  emoji: Icon(FontAwesomeIcons.eye),
                  title: Text('  NFC Tag - Read'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TagReadPage.withDependency(),
                  )),
                ),
              ],
            ),
            FormSection(
              children: [
                FormRow(
                  emoji: Icon(FontAwesomeIcons.pen),
                  title: Text('  NFC Tag - Write'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) => NdefWritePage.withDependency(),
                  )),
                ),
              ],
            ),
            // FormSection(
            //   children: [
            //     FormRow(
            //       emoji: Icon(FontAwesomeIcons.lock),
            //       title: Text('  NFC Tag - Write Lock'),
            //       trailing: Icon(Icons.chevron_right),
            //       onTap: () => Navigator.push(context, MaterialPageRoute(
            //         builder: (context) => NdefWriteLockPage.withDependency(),
            //       )),
            //     ),
            //   ],
            // ),
          //   if (Platform.isAndroid)
            
          //     // FormSection(
          //     //   children: [
          //     //     FormRow(
          //     //       emoji: Icon(FontAwesomeIcons.nfcDirectional),
          //     //       title: Text('  NFC Tag - Format'),
          //     //       trailing: Icon(Icons.chevron_right),
          //     //       onTap: () => Navigator.push(context, MaterialPageRoute(
          //     //         builder: (context) => NdefFormatPage.withDependency(),
          //     //       )),
          //     //     ),
          //     //   ],
          //     // ),
          // ]),
          // FormSection(children: [
          //   FormRow(
          //     emoji: Icon(Icons.open_in_new),
          //     title: Text('  About'),
          //     trailing: Icon(Icons.chevron_right),
          //     onTap: () => Navigator.push(context, MaterialPageRoute(
          //       builder: (context) => AboutPage(),
          //     )),
          //   ),
          // ]),
        ],
          ),
        ],
      ),
    );
  }
}

ThemeData _themeData(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
     // Matches app icon color.
    primarySwatch:  MaterialColor(0xFF4D8CFE, <int, Color>{
      50: Color(0xFFEAF1FF),
      100: Color(0xFFCADDFF),
      200: Color(0xFFA6C6FF),
      300: Color(0xFF82AFFE),
      400: Color(0xFF689DFE),
      500: Color(0xFF4D8CFE),
      600: Color(0xFF4684FE),
      700: Color(0xFF3D79FE),
      800: Color(0xFF346FFE),
      900: Color(0xFF255CFD),
    }),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      errorStyle: TextStyle(height: 0.75),
      helperStyle: TextStyle(height: 0.75),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(40),
    )),
    scaffoldBackgroundColor: brightness == Brightness.dark
      ? Colors.black
      : null,
    cardColor: brightness == Brightness.dark
      ? Color.fromARGB(255, 28, 28, 30)
      : null,
    dialogTheme: DialogTheme(
      backgroundColor: brightness == Brightness.dark
        ? Color.fromARGB(255, 28, 28, 30)
        : null,
    ),
    highlightColor: brightness == Brightness.dark
      ? Color.fromARGB(255, 44, 44, 46)
      : null,
    splashFactory: NoSplash.splashFactory,
  );
}
